# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../function_app_service_plan_fn2public",
      "../cosmosdb_account_01",
      "../storage_account_appdata",
      "../storage_account_fn2public"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_function_app"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

plan_name            = "fn2public"
storage_account_name = "fn2public"
functionapp_name     = "2-public"

functionapp_settings = [
  {
    name  = "COSMOSDB_NAME"
    value = "io-prod-sqldb-db-01"
  },
  {
    name  = "FUNCTION_APP_EDIT_MODE"
    value = "readonly"
  },
  {
    name  = "WEBSITE_NODE_DEFAULT_VERSION"
    value = "10.14.1"
  },
  {
    name  = "WEBSITE_RUN_FROM_PACKAGE"
    value = "1" 
  },
  {
    name  = "MESSAGE_CONTAINER_NAME"
    value = "message-content"
  },
  {
    name  = "PUBLIC_API_URL"
    value = "https://io-prod-apim-01.azure-api.net"
  },
  {
    name  = "WEBSITE_HTTPSCALEV2_ENABLED"
    value = "1"
  },
  {
    name  = "FUNCTIONS_EXTENSION_VERSION"
    value = "~2"
  },
  {
    name  = "SUBSCRIPTIONS_FEED_TABLE"
    value = "SubscriptionsFeedByDay"
  },
  {
    name  = "MAIL_FROM"
    value = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
  },
  {
    name  = "MAIL_ORGANIZATION_FISCALCODE"
    value = "80188230587"
  },
  {
    name  = "MAIL_ORGANIZATION_NAME"
    value = "Presidenza del Consiglio dei Ministri"
  },
  {
    name  = "MAIL_SENDER_SERVICE"
    value = "Team per la Trasformazione Digitale<br />Progetto IO"
  },
  {
    name  = "FUNCTIONS_PUBLIC_URL"
    # TODO: Change this when io-functions-public will be deployed
    value = "https://localhost/public"
  }
]

functionapp_settings_secrets = [
  {
    name        = "MAILUP_USERNAME"
    vault_alias = "fn2CommonsMailupUsername"
  },
  {
    name        = "MAILUP_SECRET"
    vault_alias = "fn2CommonsMailupSecret"
  },
]

functionapp_connection_strings = [
]