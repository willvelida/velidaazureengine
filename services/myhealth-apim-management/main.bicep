param apimName string = 'myhealthapiportal'
param apimLocation string = 'australiaeast'
param publisherName string = 'MyHealth API Portal'
param publisherEmail string = 'willvelida@hotmail.co.uk'

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
