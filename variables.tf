variable "plan" {
  type = string
  default = "vc2-2c-4gb"
  #get here: curl "https://api.vultr.com/v2/plans"   -X GET   -H "Authorization: Bearer <API_TOKEN>"
}

variable "region" {
  type    = string
  default = "sgp"
}

variable "os_id" {
  type = number
  default = 381
  #get here: curl "https://api.vultr.com/v2/os"   -X GET   -H "Authorization: Bearer <API_TOKEN>"
}

variable "label" {
  type    = string
  default = "TDA-X"
}
