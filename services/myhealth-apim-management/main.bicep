param apimName string
param apimLocation string
param publisherName string
param publisherEmail string

resource myhealthapim 'Microsoft.ApiManagement/service@2019-12-01' = {
  name: apimName
  location: apimLocation
  sku: {
    name: 'Developer'
    capacity: 1
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}
