package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestNetwork(t *testing.T) {
	t.Parallel()

	fixtureFolder := "./fixtures/network"

	// Deploy network and subnets
	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := configureTerraformOptions(t, fixtureFolder)

		// Save the options to test in stages
		test_structure.SaveTerraformOptions(t, fixtureFolder, terraformOptions)

		// Init and apply the resources and throws a fail if have errors
		terraform.InitAndApply(t, terraformOptions)
	})

	// Check the length id of network id
	test_structure.RunTestStage(t, "validate", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)

		networkID := terraform.Output(t, terraformOptions, "virtual_network_id")
		if len(networkID) <= 0 {
			t.Fatal("Wrong output")
		}
	})

	// Clean up resources created
	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)
		terraform.Destroy(t, terraformOptions)
	})
}

func configureTerraformOptions(t *testing.T, fixtureFolder string) *terraform.Options {
	terraformOptions := &terraform.Options{
		// The path of the terraform code is located
		TerraformDir: fixtureFolder,

		// Variables to pass to our terraform code
		Vars: map[string]interface{}{},
	}

	return terraformOptions
}
