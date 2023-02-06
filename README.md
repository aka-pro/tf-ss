# tf_django

Steps To install Terraform:

1.Download the Terraform executable from the official website: https://www.terraform.io/downloads.html
2.Extract the archive and place the Terraform executable in a directory that is part of your system's PATH.

Configure Azurerm provider:

1.Create a Service Principal with a Client Secret for the Azure subscription.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
2.Update the provider block in the provider.tf file with the values of service principle.

Steps to Run Terraform locally:

1.Run the "terraform init" command to initialize Terraform and download the necessary providers and plugins.
2.Run the "terraform plan" command to generate a plan of the changes.
3.Review the changes described in the plan and verify that they are what you expect.
4.Run the "terraform apply" command to apply the changes.
5.Terraform will prompt you for confirmation before applying the changes. Type "yes" to continue or "no" to cancel.