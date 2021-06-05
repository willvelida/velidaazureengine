param dataFactoryName string = 'velidadatafactory'
param location string = 'australiaeast'

resource velidadatafactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  tags: {}
  properties: {}
}
