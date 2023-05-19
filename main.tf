resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "agentId" = {
                "type" = "string"
            },
            "conversationId" = {
                "type" = "string"
            }
        },
        "required" = [
            "conversationId",
            "agentId"
        ],
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\r\n \"id\": \"$${input.agentId}\" \r\n}"
        request_type         = "POST"
        request_url_template = "/api/v2/conversations/$${input.conversationId}/assign"
        headers = {
			UserAgent = "PureCloudIntegrations/1.0"
			Content-Type = "application/json"
		}
    }

    config_response {
        success_template = "$${rawResult}"
    }
}