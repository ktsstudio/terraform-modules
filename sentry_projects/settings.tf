terraform {
  required_providers {
    sentry = {
      source  = "jianyuan/sentry"
      version = "~> 0.6.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}
