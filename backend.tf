terraform{
    required_providers{
        azurerm = {
            source = "hashicrop/azurerm"
            version ="3.107.0"
        }
    }

    backend "azurerm"{
        resource_group_name = "tfstate"
        storage_account_name = module.app.vdesktop-storage-01.name #storage account created from 'app' child module
        container_name = "tfstate"
        key="terrafrom.tfstate"
    }

}

provider "azurerm"{
    features {}
}

module "app"{
    source ="./app"
}