package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVMConnectivity(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	publicIP := terraform.Output(t, terraformOptions, "public_ip")
	assert.NotEmpty(t, publicIP)

	key, err := os.ReadFile("/Users/abhinavsingh/.ssh/id_rsa")
	if err != nil {
		t.Fatal("Failed to read private key:", err)
	}

	host := ssh.Host{
		Hostname:    publicIP,
		SshUserName: "azureuser",
		SshKeyPair: &ssh.KeyPair{
			PrivateKey: string(key),
		},
	}

	// Check SSH connection
	ssh.CheckSshConnection(t, host)

	// Run uname -a
	output := ssh.CheckSshCommand(t, host, "uname -a")
	t.Logf("VM OS: %s", output)
}
