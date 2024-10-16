package test

import (
	"fmt"
	"os"
	"testing"
	//"time"
	"io/ioutil"
	"strings"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/hashicorp/hcl/v2/hclsimple"

	"go.mercari.io/hcledit"
)

type LockFile struct {
    Provider []ProviderInfo `hcl:"provider,block"`
}

type ProviderInfo struct {
    Name    string `hcl:"name,label"`
    Version string `hcl:"version"`
    Constraints string   `hcl:"constraints,optional"`
    Hashes      []string `hcl:"hashes,optional"`
}
func GetProviderVersions(lockFilePath string) (map[string]string, error) {
    var lockFile LockFile

    // Decode the terraform.lock.hcl file
    err := hclsimple.DecodeFile(lockFilePath, nil, &lockFile)
    if err != nil {
        return nil, fmt.Errorf("failed to parse lock file: %w", err)
    }

    // Create a map to store the providers and their versions
    providerVersions := make(map[string]string)

    // Populate the map with provider name as key and version as value
    for _, provider := range lockFile.Provider {
        fmt.Printf("Found provider: %s, version: %s\n", provider.Name, provider.Version)
        providerVersions[provider.Name] = provider.Version
    }

    if len(providerVersions) == 0 {
        fmt.Println("Warning: No provider versions found in lock file.")
    }

    return providerVersions, nil
}

func CreateFile(fileName string, content string) error {
        file, err := os.Create(fileName)
        if err != nil {
                return fmt.Errorf("Error: %w", err)
        }
        defer file.Close()

        _, err = file.WriteString(content)
        if err != nil {
                return fmt.Errorf("Error: %w", err)
        }

        return nil
}

func TestTerraformAwsSecurityGroup(t *testing.T) {
	t.Parallel()

	results := [][]string{
		{"Version", "Validate"},
	}

	versions := []string{
		//"~> 3.0",
		"~> 4.0",
		"~> 5.0",
	}

	lockFilePath := "../.terraform.lock.hcl"
	provider := "registry.terraform.io/hashicorp/aws"

	for _, version := range versions {
		t.Run("TestProviderVersion_"+strings.Replace(version, "~>", "", -1), func(t *testing.T) {
			updateProviderVersion("../main.tf", version)
			terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
				TerraformDir: "../",
				NoColor: true,
				Upgrade: true,
			})
			validateSuccess := true
			planSuccess := true
			applySuccess := true
			providerVersions := make(map[string]string)

			defer terraform.Destroy(t, terraformOptions)
			defer func() {
				providerVersion, exists := providerVersions[provider]
				if !exists {
					t.Fatalf("Error: provider version not found in providerVersions: %v", providerVersions)
				}
				addResult(&results, providerVersion, validateSuccess, planSuccess, applySuccess)
			}()

			terraform.Init(t, terraformOptions)

			providerVersions, _ = GetProviderVersions(lockFilePath)

			fmt.Printf("Provider versions: %v\n", providerVersions)

			_, err := terraform.ValidateE(t, terraformOptions)
			if err != nil {
				validateSuccess = false
			}
			_, err = terraform.PlanE(t, terraformOptions)
			if err != nil {
				planSuccess = false
			}
			_, err = terraform.ApplyE(t, terraformOptions)
			if err != nil {
				applySuccess = false
			}
		})
	}
	printMarkdownMatrix(results)
}

func updateProviderVersion(filePath string, version string) {
    input, err := ioutil.ReadFile(filePath)
    if err != nil {
        panic(err)
    }

    // Remplacer la ligne de version
    //output := strings.Replace(string(input), `version = "~> 3.0"`, `version = "`+version+`"`, -1)
    editor, _ := hcledit.Read(strings.NewReader(string(input)), "")

    editor.Update("terraform.required_providers.aws.version", version)
    

    //re := regexp.MustCompile(`version\s*=\s*".*?"`)
    //output := re.ReplaceAllString(string(input), `version = "`+version+`"`)

    // Réécrire le fichier avec la nouvelle version
    err = ioutil.WriteFile(filePath, editor.Bytes(), 0644)
    //err = ioutil.WriteFile(filePath, []byte(output), 0644)
    if err != nil {
        panic(err)
    }
}

func addResult(results *[][]string, version string, validate bool, plan bool, apply bool) {
    validateResult := "success"
    if !validate {
        validateResult = "fail"
    }
    planResult := "success"
    if !plan {
        planResult = "fail"
    }
    applyResult := "success"
    if !apply {
        applyResult = "fail"
    }
    *results = append(*results, []string{version, validateResult, planResult, applyResult})
}

func printMarkdownMatrix(results [][]string) {
    fmt.Println("\n### Terraform Provider Test Results")
    fmt.Println("| Version | Validate| Plan | Apply")
    fmt.Println("|---------|---------|-------|------|")
    for _, row := range results[1:] {
        fmt.Printf("| %s | %s | %s | %s |\n", row[0], row[1], row[2], row[3])
    }
}
