<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  exclude-result-prefixes="xsl xs fx" 
  version="1.0" 
  
  xml:space="default" 
  
  
  xmlns:cfdi="http://www.sat.gob.mx/cfd/3" 
  xmlns:fx="http://www.fact.com.mx/schema/fx" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no"/>
  
<xsl:strip-space elements="*"/><!-- sin efecto -->
  <!-- **** -->

  <xsl:variable name="nativeVersion">
    <xsl:choose>
      <xsl:when test="number(/fx:FactDocMX/fx:Version) != 7">
        <xsl:message terminate="yes">
          <xsl:value-of select="'La transformación fx-cfdiv33 solo funciona con el XML nativo F v.7.'"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="/fx:FactDocMX/fx:Version"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    
<!-- <xsl:message>'Hola desde fx-cfdv33.xslt'</xsl:message>-->
    

    <cfdi:Comprobante>
      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="normalize-space('http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd')">
          
        </xsl:value-of>
      </xsl:attribute>

      <xsl:attribute name="Version">
        <xsl:value-of select="'3.3'"/>
      </xsl:attribute>

      <xsl:if test="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:Serie">
        <xsl:attribute name="Serie">
          <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:Serie"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:Folio">
        <xsl:attribute name="Folio">
          <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:Folio"/>
        </xsl:attribute>
      </xsl:if>
      
          
      <xsl:attribute name="Fecha">
        <xsl:choose>
          <xsl:when test="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:TiempoDeEmision">
            <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:AsignacionSolicitada/fx:TiempoDeEmision"/>            
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'2017-04-07T17:24:16'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:attribute name="Sello">
        <xsl:value-of select="'YQ=='"/>
      </xsl:attribute>

      <xsl:if test="/fx:FactDocMX/fx:Totales/fx:FormaDePago">
      <xsl:attribute name="FormaPago">
        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:FormaDePago"/>
      </xsl:attribute>
      </xsl:if>

      <xsl:attribute name="NoCertificado">
        <xsl:value-of select="'11111111111111111111'"/>
      </xsl:attribute>

      <xsl:attribute name="Certificado">
        <xsl:value-of select="'YQ=='"/>
      </xsl:attribute>


      <xsl:if test="/fx:FactDocMX/fx:ComprobanteEx/fx:TerminosDePago/fx:CondicionesDePago">
        <xsl:attribute name="CondicionesDePago">
          <xsl:value-of select="/fx:FactDocMX/fx:ComprobanteEx/fx:TerminosDePago/fx:CondicionesDePago"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:attribute name="SubTotal">
        <!-- 2017-05-01 probando NativoF y llego a esto: -->
        <!-- <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:SubTotal"/>-->
        <!--  2017-05-02 decisión definitiva: -->  
        
         <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:SubTotalBruto"/>
<!--        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:SubTotal"/>-->
        <!-- es tan obvio que ni se nota ... -->



      </xsl:attribute>

      <xsl:if test="/fx:FactDocMX/fx:Totales/fx:Descuento">
      <xsl:attribute name="Descuento">
        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:Descuento"/>
      </xsl:attribute>
      </xsl:if>
      
      <xsl:attribute name="Moneda">
        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:Moneda"/>
      </xsl:attribute>

      <xsl:if test="/fx:FactDocMX/fx:Totales/fx:TipoDeCambioVenta">
  <xsl:attribute name="TipoCambio">
        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:TipoDeCambioVenta"/>
      </xsl:attribute>
</xsl:if>

      <xsl:attribute name="Total">
        <xsl:value-of select="/fx:FactDocMX/fx:Totales/fx:Total"/>
      </xsl:attribute>

      <xsl:attribute name="TipoDeComprobante">
        <xsl:variable name="tipo_ingreso" select="'I'"/>
        <xsl:variable name="tipo_egreso" select="'E'"/>
        <xsl:variable name="tipo_traslado" select="'T'"/>
        <xsl:variable name="tipo_nomina" select="'N'"/>
        <xsl:variable name="tipo_pago" select="'P'"/>
        <xsl:variable name="tipoDeComprobante" select="/fx:FactDocMX/fx:Identificacion/fx:TipoDeComprobante"/>
        <xsl:choose>
          <xsl:when test="$tipoDeComprobante = 'FACTURA'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'NOTA_DE_CREDITO'">
            <xsl:value-of select="$tipo_egreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'NOTA_DE_CARGO'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'CARTA_PORTE'">
            <xsl:value-of select="$tipo_traslado"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO_DE_HONORARIOS'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO_DE_ARRENDAMIENTO'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO_DE_DONATIVOS'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO_DE_PAGO_DE_PRIMAS'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'COMPROBANTE_DE_PAGO_A_PLAZOS'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'BOLETA_DE_EMPENO'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO_DE_NOMINA'">
            <xsl:value-of select="$tipo_nomina"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'RECIBO'">
            <xsl:value-of select="$tipo_ingreso"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'PAGO'">
            <xsl:value-of select="$tipo_pago"/>
          </xsl:when>
          <xsl:when test="$tipoDeComprobante = 'TRASLADO'">
            <xsl:value-of select="$tipo_traslado"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message terminate="yes">
              <xsl:value-of select="'Tipo de comprobante desconocido: '"/>
              <xsl:value-of select="$tipoDeComprobante"/>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      
      <xsl:if test="/fx:FactDocMX/fx:ComprobanteEx/fx:TerminosDePago/fx:MetodoDePago">
      <xsl:attribute name="MetodoPago">
        <xsl:value-of select="/fx:FactDocMX/fx:ComprobanteEx/fx:TerminosDePago/fx:MetodoDePago"/>
      </xsl:attribute>
      </xsl:if>      

      <xsl:attribute name="LugarExpedicion">
        <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:LugarExpedicion"/>
      </xsl:attribute>

      <xsl:if test="/fx:FactDocMX/fx:Identificacion/fx:Confirmacion">
        <xsl:attribute name="Confirmacion">
        <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:Confirmacion"/>
      </xsl:attribute>
      </xsl:if>

      <xsl:if test="/fx:FactDocMX/fx:CfdiRelacionados">
      <xsl:element name="cfdi:CfdiRelacionados">
        <xsl:attribute name="TipoRelacion">
          <xsl:value-of select="/fx:FactDocMX/fx:CfdiRelacionados/fx:TipoRelacion"/>
        </xsl:attribute>
        <xsl:for-each select="/fx:FactDocMX/fx:CfdiRelacionados/fx:UUID">
          <xsl:element name="cfdi:CfdiRelacionado" namespace="http://www.sat.gob.mx/cfd/3">
            <xsl:attribute name="UUID">
              <xsl:value-of select="."/>
            </xsl:attribute>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
      </xsl:if>
      
      
      <cfdi:Emisor>
        <xsl:attribute name="Rfc">
          <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:RFCEmisor"/>
        </xsl:attribute>

        <xsl:if test="/fx:FactDocMX/fx:Identificacion/fx:RazonSocialEmisor">
          <xsl:attribute name="Nombre">
            <xsl:value-of select="/fx:FactDocMX/fx:Identificacion/fx:RazonSocialEmisor"/>
          </xsl:attribute>
        </xsl:if>


            <xsl:attribute name="RegimenFiscal">
              <xsl:value-of select="/fx:FactDocMX/fx:Emisor/fx:RegimenFiscal/fx:Regimen"/>
            </xsl:attribute>

      </cfdi:Emisor>






      <cfdi:Receptor>
        <xsl:attribute name="Rfc">
          <xsl:value-of select="/fx:FactDocMX/fx:Receptor/fx:RFCReceptor"/>
        </xsl:attribute>

        <xsl:if test="/fx:FactDocMX/fx:Receptor/fx:NombreReceptor">
          <xsl:attribute name="Nombre">
            <xsl:value-of select="/fx:FactDocMX/fx:Receptor/fx:NombreReceptor"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="/fx:FactDocMX/fx:Receptor/fx:ResidenciaFiscal">
          <xsl:attribute name="ResidenciaFiscal">
            <xsl:value-of select="/fx:FactDocMX/fx:Receptor/fx:ResidenciaFiscal"/>
          </xsl:attribute>
        </xsl:if>
        
        <xsl:if test="/fx:FactDocMX/fx:Receptor/fx:TaxID">
          <xsl:attribute name="NumRegIdTrib">
            <xsl:value-of select="/fx:FactDocMX/fx:Receptor/fx:TaxID"/>
          </xsl:attribute>
        </xsl:if>
        
        <xsl:attribute name="UsoCFDI">
          <xsl:value-of select="/fx:FactDocMX/fx:Receptor/fx:UsoCFDI"/>
        </xsl:attribute>
        

      </cfdi:Receptor>

      <cfdi:Conceptos>
        <xsl:for-each select="/fx:FactDocMX/fx:Conceptos/fx:Concepto">

          <cfdi:Concepto>


            <xsl:attribute name="ClaveProdServ">
              <xsl:value-of select="./fx:ClaveProdServ"/>
            </xsl:attribute>

            <xsl:if test="./fx:Codigo">
              <xsl:attribute name="NoIdentificacion">
                <xsl:value-of select="./fx:Codigo"/>
            </xsl:attribute>
            </xsl:if>

            <xsl:attribute name="Cantidad">
              <xsl:value-of select="./fx:Cantidad"/>
            </xsl:attribute>
            
            <xsl:attribute name="ClaveUnidad">
              <xsl:value-of select="./fx:ClaveUnidad"/>
            </xsl:attribute>
            
            <xsl:if test="./fx:UnidadDeMedida">
              <xsl:attribute name="Unidad">
                <xsl:value-of select="./fx:UnidadDeMedida"/>
              </xsl:attribute>
            </xsl:if>
            
            <xsl:attribute name="Descripcion">
              <xsl:value-of select="./fx:Descripcion"/>
            </xsl:attribute>
            
            <xsl:attribute name="ValorUnitario">
              <xsl:value-of select="./fx:ValorUnitario"/>
            </xsl:attribute>
            
            <xsl:attribute name="Importe">
              <xsl:value-of select="./fx:Importe"/>
            </xsl:attribute>
            
            <xsl:if test="./fx:Descuento">
<!--              <xsl:if test="not(number(./fx:Descuento) = number(0))">-->
              <xsl:attribute name="Descuento">
                <xsl:value-of select="./fx:Descuento"/>
              </xsl:attribute>
            <!--</xsl:if>-->
            </xsl:if>

            <!-- inicio impuestos concepto -->
            <xsl:if test="./fx:ImpuestosSAT">
              <cfdi:Impuestos>
                <!-- inicio concepto traslados (no tengo tiempo ahora para identity transform) -->
                <xsl:if test="./fx:ImpuestosSAT/fx:Traslados">
                  <cfdi:Traslados>
                    <xsl:for-each select="./fx:ImpuestosSAT/fx:Traslados/fx:Traslado">
                      <cfdi:Traslado>
                        <xsl:attribute name="Base">
                          <xsl:value-of select="./@Base"/>
                        </xsl:attribute>
                        <xsl:attribute name="Impuesto">
                          <xsl:value-of select="./@Impuesto"/>
                        </xsl:attribute>
                        <xsl:attribute name="TipoFactor">
                          <xsl:value-of select="./@TipoFactor"/>
                        </xsl:attribute>
                        
                        <xsl:if test="./@TasaOCuota">
                        <xsl:attribute name="TasaOCuota">
                          <xsl:value-of select="./@TasaOCuota"/>
                        </xsl:attribute>
                        </xsl:if>
                        
                        <xsl:if test="./@Importe">
                          <xsl:attribute name="Importe">
                            <xsl:value-of select="./@Importe"/>
                          </xsl:attribute>
                        </xsl:if>

                      </cfdi:Traslado>
                    </xsl:for-each>
                  </cfdi:Traslados>
                </xsl:if>
                <!-- fin concepto traslados -->
                
                
                <!-- inicio concepto retenciones -->
                <xsl:if test="./fx:ImpuestosSAT/fx:Retenciones">
                  <cfdi:Retenciones>
                    <xsl:for-each select="./fx:ImpuestosSAT/fx:Retenciones/fx:Retencion">
                      <cfdi:Retencion>
                        <xsl:attribute name="Base">
                          <xsl:value-of select="./@Base"/>
                        </xsl:attribute>
                        <xsl:attribute name="Impuesto">
                          <xsl:value-of select="./@Impuesto"/>
                        </xsl:attribute>
                        <xsl:attribute name="TipoFactor">
                          <xsl:value-of select="./@TipoFactor"/>
                        </xsl:attribute>
                        
                          <xsl:attribute name="TasaOCuota">
                            <xsl:value-of select="./@TasaOCuota"/>
                          </xsl:attribute>
                        
                          <xsl:attribute name="Importe">
                            <xsl:value-of select="./@Importe"/>
                          </xsl:attribute>
                        
                      </cfdi:Retencion>
                    </xsl:for-each>
                  </cfdi:Retenciones>
                </xsl:if>
                <!-- fin concepto retenciones -->
                
              </cfdi:Impuestos>  
            </xsl:if>            
            <!-- fin concepto impuestos -->
            
            

           <!-- en el pattern de numero de pedimiento hay 2 espacios consecutivos que .net no puede preservar -->
            <xsl:if test="count(./fx:Opciones/fx:DatosDeImportacion/fx:InformacionAduanera) &gt; 0">
              <xsl:for-each select="./fx:Opciones/fx:DatosDeImportacion/fx:InformacionAduanera">
                <cfdi:InformacionAduanera>
                  <xsl:attribute name="NumeroPedimento">
                    <xsl:value-of select="./fx:NumeroDePedimento"/>
                  </xsl:attribute>
                </cfdi:InformacionAduanera>
              </xsl:for-each>
            </xsl:if>

            <xsl:if test="./fx:Opciones/fx:CuentaPredial">
              <cfdi:CuentaPredial>
                <xsl:attribute name="Numero">
                  <xsl:value-of select="./fx:Opciones/fx:CuentaPredial"/>
                </xsl:attribute>
              </cfdi:CuentaPredial>
            </xsl:if>

            <!-- complementos a nivel concepto -->

            <xsl:if test="./fx:Opciones/fx:ComplementoConcepto">

              <!-- estos son a la vieja usanza -->
              <cfdi:ComplementoConcepto>

                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:VentaVehiculos">
                  <xsl:call-template name="VentaVehiculos">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:VentaVehiculos"/>
                  </xsl:call-template>
                </xsl:if>

                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:InstEducativas">
                  <xsl:call-template name="InstEducativas">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:InstEducativas"/>
                  </xsl:call-template>
                </xsl:if>

                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:PorCuentaDeTerceros">
                  <!-- 
                  <xsl:call-template name="PorCuentaDeTerceros">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:PorCuentaDeTerceros"/>
                  </xsl:call-template>
                  -->
                  <!-- ya no se puede generar pero sin onvalidar los existentes -->
                  <xsl:message terminate="yes">Ya no se puede generar el complemento de terceros mediante el elemento nativo PorCuentaDeTerceros. Por favor emplear el elemento nativo PorCuentadeTerceros (nota la diferencia: D vs. d).</xsl:message>
                </xsl:if>


                <!-- estos son a la nueva usanza : pegados del SAT -->
                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:PorCuentadeTerceros">
                  <xsl:call-template name="Complemento1">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:PorCuentadeTerceros"/>
                    <xsl:with-param name="ns" select="'http://www.sat.gob.mx/terceros'"/>
                    <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros11.xsd'"/>
                    <xsl:with-param name="px" select="'terceros'"/>
                  </xsl:call-template>
                </xsl:if>

                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:VentaVehiculos11">
                  <xsl:call-template name="Complemento3">
                    <xsl:with-param name="name" select="'VentaVehiculos'"/>
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:VentaVehiculos11"/>
                    <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ventavehiculos'"/>
                    <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ventavehiculos/ventavehiculos11.xsd'"/>
                    <xsl:with-param name="px" select="'ventavehiculos'"/>
                  </xsl:call-template>
                </xsl:if>

                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:acreditamientoIEPS">
                  <xsl:call-template name="Complemento1">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:acreditamientoIEPS"/>
                    <xsl:with-param name="ns" select="'http://www.sat.gob.mx/acreditamiento'"/>
                    <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/acreditamiento/AcreditamientoIEPS10.xsd'"/>
                    <xsl:with-param name="px" select="'aieps'"/>
                  </xsl:call-template>
                </xsl:if>

                <!-- 2016-04-11- resulta que debe de ir a nivel comprobante -->
                <!-- estamos consultando pero ahora ya estamos preparando el cambio -->
                <!-- esta ocurrencia es A NIVEL CONCEPTO que se tendrá que deshabilitar -->
                <xsl:if test="./fx:Opciones/fx:ComplementoConcepto/fx:INE">
                  <!--
                  <xsl:call-template name="Complemento1">
                    <xsl:with-param name="node" select="./fx:Opciones/fx:ComplementoConcepto/fx:INE"/>
                    <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ine'"/>
                    <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ine/ine10.xsd'"/>
                    <xsl:with-param name="px" select="'ine'"/>
                 </xsl:call-template>
                 -->
                  <xsl:message terminate="yes">Ya no se puede generar el complemento INE a nivel de concepto</xsl:message>
                </xsl:if>


              </cfdi:ComplementoConcepto>
            </xsl:if>

            <xsl:for-each select="./fx:Opciones/fx:Parte">
              
              <!-- estos son a la nueva usanza : pegados del SAT -->
                <xsl:call-template name="Elemento1">
                  <xsl:with-param name="node" select="."/>
                </xsl:call-template>
            
            </xsl:for-each>


          </cfdi:Concepto>
        </xsl:for-each>
      </cfdi:Conceptos>

    <!-- imnicio comprobante impuestos -->
      
      <xsl:if test="/fx:FactDocMX/fx:ImpuestosSAT">
      <cfdi:Impuestos>
        
        <xsl:if test="/fx:FactDocMX/fx:ImpuestosSAT/@TotalImpuestosRetenidos">
          <xsl:attribute name="TotalImpuestosRetenidos" >
            <xsl:value-of select="/fx:FactDocMX/fx:ImpuestosSAT/@TotalImpuestosRetenidos"/>
          </xsl:attribute>
        </xsl:if>
        
        <xsl:if test="/fx:FactDocMX/fx:ImpuestosSAT/@TotalImpuestosTrasladados">
          <xsl:attribute name="TotalImpuestosTrasladados" >
            <xsl:value-of select="/fx:FactDocMX/fx:ImpuestosSAT/@TotalImpuestosTrasladados"/>
          </xsl:attribute>
        </xsl:if>

      <!-- foreach retenciones si es que esisten -->
        <xsl:if test="/fx:FactDocMX/fx:ImpuestosSAT/fx:Retenciones">
          <cfdi:Retenciones>
            <xsl:for-each select="/fx:FactDocMX/fx:ImpuestosSAT/fx:Retenciones/fx:Retencion">
            <cfdi:Retencion>
              <xsl:attribute name="Impuesto">
                <xsl:value-of select="./@Impuesto"/>
              </xsl:attribute>
              <xsl:attribute name="Importe">
                <xsl:value-of select="./@Importe"/>
              </xsl:attribute>
              
            </cfdi:Retencion>
          </xsl:for-each>
          </cfdi:Retenciones>
        </xsl:if>        
        
        <!-- foreach traslados si es que esisten -->
        <xsl:if test="/fx:FactDocMX/fx:ImpuestosSAT/fx:Traslados">
          <cfdi:Traslados>
            <xsl:for-each select="/fx:FactDocMX/fx:ImpuestosSAT/fx:Traslados/fx:Traslado">
              <cfdi:Traslado>
                <xsl:attribute name="Impuesto">
                  <xsl:value-of select="./@Impuesto"/>
                </xsl:attribute>
                <xsl:attribute name="TipoFactor">
                  <xsl:value-of select="./@TipoFactor"/>
                </xsl:attribute>
                <xsl:attribute name="TasaOCuota">
                  <xsl:value-of select="./@TasaOCuota"/>
                </xsl:attribute>
                
                <xsl:attribute name="Importe">
                  <xsl:value-of select="./@Importe"/>
                </xsl:attribute>
              </cfdi:Traslado>
            </xsl:for-each>
          </cfdi:Traslados>
        </xsl:if>        
      </cfdi:Impuestos>
    </xsl:if>
<!-- fin comprobante impuestos -->
      




      <!-- complementos a nivel comprobante -->

      <!-- ojo: 
        hay 4 complementos que no deben de disparar la creación del nodo cfdi:Complemento 
        porque están procesándose a nivel de código .net (clases, a la antigüa)
        Divisas
        ImpLocal
        Donatarias
        Donatarias11 (que es el mismo lógicamente)
        (El complemento Detallista se hace como si fuera una addenda.)
        Por lo tanto, el test inicial tiene que ser más complejo.
        Tiene que listar todos los complementos que tienen esta mecánica.
      -->
      <!-- en el Pago de especie hay un regex que no concuerda con lenght: L=25 R= 24..26-->

      <!-- MYS-696 no se generan lyendas fiscales -->
      <!-- tal parece que este complemento nunca se generaba; o se generabe en el código y dejó de hacerlo -->
      <!-- lo incluimos como si fuera el copiado del SAT, pero el el ULTIMO que no lo es y requiere un template propieratio -->

      <xsl:if
        test="/fx:FactDocMX/fx:Complementos/fx:Nomina 
        or /fx:FactDocMX/fx:Complementos/fx:Nomina12 
        or /fx:FactDocMX/fx:Complementos/fx:PagoEnEspecie 
        or /fx:FactDocMX/fx:Complementos/fx:Aerolineas 
        or /fx:FactDocMX/fx:Complementos/fx:ValesDeDespensa 
        or /fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles 
        or /fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles11 
        or /fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible 
        or /fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible11 
        or /fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible12 
        or /fx:FactDocMX/fx:Complementos/fx:NotariosPublicos 
        or /fx:FactDocMX/fx:Complementos/fx:LeyendasFiscales 
        or /fx:FactDocMX/fx:Complementos/fx:VehiculoUsado 
        or /fx:FactDocMX/fx:Complementos/fx:renovacionysustitucionvehiculos 
        or /fx:FactDocMX/fx:Complementos/fx:certificadodedestruccion 
        or /fx:FactDocMX/fx:Complementos/fx:parcialesconstruccion 
        or /fx:FactDocMX/fx:Complementos/fx:INE 
        or /fx:FactDocMX/fx:Complementos/fx:INE11 
        or /fx:FactDocMX/fx:Complementos/fx:ComercioExterior
        or /fx:FactDocMX/fx:Complementos/fx:ComercioExterior11
        or /fx:FactDocMX/fx:Complementos/fx:Pagos
        or /fx:FactDocMX/fx:Complementos/fx:ImpuestosLocales
        or /fx:FactDocMX/fx:Complementos/fx:TuristaPasajeroExtranjero
        or /fx:FactDocMX/fx:Complementos/fx:PFintegranteCoordinado
        or /fx:FactDocMX/fx:Complementos/fx:obrasarteantiguedades
        or /fx:FactDocMX/fx:Complementos/fx:detallista
        or /fx:FactDocMX/fx:Complementos/fx:IngresosHidrocarburos
        or /fx:FactDocMX/fx:Complementos/fx:GastosHidrocarburos
        or /fx:FactDocMX/fx:Complementos/fx:CUV
        "        
        >
        <cfdi:Complemento>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:Nomina">

            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:Nomina"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/nomina'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina11.xsd'"/>
              <xsl:with-param name="px" select="'nomina'"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- nueva version 12 -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:Nomina12">
            <xsl:for-each select="/fx:FactDocMX/fx:Complementos/fx:Nomina12">
                <xsl:call-template name="Complemento3">
                  <xsl:with-param name="name" select="'Nomina'"/>
<!--                  <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:Nomina12"/>-->
                  <xsl:with-param name="node" select="."/>
                  <xsl:with-param name="ns" select="'http://www.sat.gob.mx/nomina12'"/>
                  <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina12.xsd'"/>
                  <xsl:with-param name="px" select="'nomina12'"/>
                </xsl:call-template>
              </xsl:for-each>
          </xsl:if>



          <!-- -->

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:PagoEnEspecie">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:PagoEnEspecie"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/pagoenespecie'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/pagoenespecie/pagoenespecie.xsd'"/>
              <xsl:with-param name="px" select="'pagoenespecie'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:Aerolineas">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:Aerolineas"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/aerolineas'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/aerolineas/aerolineas.xsd'"/>
              <xsl:with-param name="px" select="'aerolineas'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ValesDeDespensa">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ValesDeDespensa"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/valesdedespensa'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/valesdedespensa/valesdedespensa.xsd'"/>
              <xsl:with-param name="px" select="'valesdedespensa'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/consumodecombustibles'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/consumodecombustibles/consumodecombustibles.xsd'"/>
              <xsl:with-param name="px" select="'consumodecombustibles'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles11">
            <xsl:call-template name="Complemento3">
              <xsl:with-param name="name" select="'ConsumoDeCombustibles'"/>
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ConsumoDeCombustibles11"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ConsumoDeCombustibles11'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/consumodecombustibles/consumodeCombustibles11.xsd'"/>
              <xsl:with-param name="px" select="'consumodecombustibles11'"/>
            </xsl:call-template>
          </xsl:if>

          <!-- aqui es donde se puede deshabilitar con facilidad diciendo NO -->
          <!-- -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ecc'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ecc/ecc.xsd'"/>
              <xsl:with-param name="px" select="'ecc'"/>
            </xsl:call-template>
          </xsl:if>
          <!-- -->

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible11">
            <xsl:call-template name="Complemento3">
              <xsl:with-param name="name" select="'EstadoDeCuentaCombustible'"/>
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible11"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/EstadoDeCuentaCombustible'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/EstadoDeCuentaCombustible/ecc11.xsd'"/>
              <xsl:with-param name="px" select="'ecc11'"/>
            </xsl:call-template>
          </xsl:if>

          <!-- nuevo version 12 -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible12">
            <xsl:call-template name="Complemento3">
              <xsl:with-param name="name" select="'EstadoDeCuentaCombustible'"/>
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:EstadoDeCuentaCombustible12"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/EstadoDeCuentaCombustible12'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/EstadoDeCuentaCombustible/ecc12.xsd'"/>
              <xsl:with-param name="px" select="'ecc12'"/>
            </xsl:call-template>
          </xsl:if>
          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:NotariosPublicos">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:NotariosPublicos"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/notariospublicos'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/notariospublicos/notariospublicos.xsd'"/>
              <xsl:with-param name="px" select="'notariospublicos'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:LeyendasFiscales">
            <xsl:call-template name="LeyendasFiscales">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:LeyendasFiscales"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/leyendasFiscales'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/leyendasFiscales/leyendasFisc.xsd'"/>
              <xsl:with-param name="px" select="'leyendasFisc'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:VehiculoUsado">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:VehiculoUsado"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/vehiculousado'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/vehiculousado/vehiculousado.xsd'"/>
              <xsl:with-param name="px" select="'vehiculousado'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:renovacionysustitucionvehiculos">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:renovacionysustitucionvehiculos"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/renovacionysustitucionvehiculos'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/renovacionysustitucionvehiculos/renovacionysustitucionvehiculos.xsd'"/>
              <xsl:with-param name="px" select="'decreto'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:certificadodedestruccion">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:certificadodedestruccion"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/certificadodestruccion'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/certificadodestruccion/certificadodedestruccion.xsd'"/>
              <xsl:with-param name="px" select="'destruccion'"/>
            </xsl:call-template>
          </xsl:if>

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:parcialesconstruccion">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:parcialesconstruccion"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/servicioparcialconstruccion'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/servicioparcialconstruccion/servicioparcialconstruccion.xsd'"/>
              <xsl:with-param name="px" select="'servicioparcial'"/>
            </xsl:call-template>
          </xsl:if>

          <!-- 2016-04-11- resulta que debe de ir a nivel comprobante -->
          <!-- estamos consultando pero ahora ya estamos preparando el cambio -->
          <!-- copiado y pegado de complemento concepto, con xpath cambiado -->
          <!-- esta ocurrencia SI ES A NIVEL COM PROBANTE -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:INE">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:INE"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ine'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ine/INE10.xsd'"/>
              <xsl:with-param name="px" select="'ine'"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- nuevo version 11 -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:INE11">
            <xsl:call-template name="Complemento3">
              <xsl:with-param name="name" select="'INE'"/>
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:INE11"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ine'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ine/INE11.xsd'"/>
              <xsl:with-param name="px" select="'ine'"/>
            </xsl:call-template>
          </xsl:if>
          <!-- -->

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ComercioExterior">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ComercioExterior"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ComercioExterior'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior/ComercioExterior10.xsd'"/>
              <xsl:with-param name="px" select="'cce'"/>
            </xsl:call-template>
          </xsl:if>

          <!-- nueva version 11 -->
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ComercioExterior11">
            <xsl:call-template name="Complemento3">
              <xsl:with-param name="name" select="'ComercioExterior'"/>
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ComercioExterior11"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/ComercioExterior11'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior11/ComercioExterior11.xsd'"/>
              <xsl:with-param name="px" select="'cce11'"/>
            </xsl:call-template>
          </xsl:if>
          <!-- -->

          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:Pagos">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:Pagos"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/Pagos'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd'"/>
              <xsl:with-param name="px" select="'pago10'"/>
            </xsl:call-template>
          </xsl:if>
          

          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:ImpuestosLocales">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:ImpuestosLocales"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/implocal'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd'"/>
              <xsl:with-param name="px" select="'implocal'"/>
            </xsl:call-template>
          </xsl:if>
          



          <!-- nuevos 2017-11-15-->          

          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:TuristaPasajeroExtranjero">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:TuristaPasajeroExtranjero"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/TuristaPasajeroExtranjero'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/TuristaPasajeroExtranjero/TuristaPasajeroExtranjero.xsd'"/>
              <xsl:with-param name="px" select="'tpe'"/>
            </xsl:call-template>
          </xsl:if>
          

          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:PFintegranteCoordinado">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:PFintegranteCoordinado"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/pfic'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/pfic/pfic.xsd'"/>
              <xsl:with-param name="px" select="'pfic'"/>
            </xsl:call-template>
          </xsl:if>
          

          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:obrasarteantiguedades">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:obrasarteantiguedades"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/arteantiguedades'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/arteantiguedades/obrasarteantiguedades.xsd'"/>
              <xsl:with-param name="px" select="'obrasarte'"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:detallista">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:detallista"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/detallista'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/detallista/detallista.xsd'"/>
              <xsl:with-param name="px" select="'detallista'"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- hidrocarburos -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:GastosHidrocarburos">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:GastosHidrocarburos"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/GastosHidrocarburos10'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/GastosHidrocarburos10/GastosHidrocarburos10.xsd'"/>
              <xsl:with-param name="px" select="'gceh'"/>
            </xsl:call-template>
          </xsl:if>
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:IngresosHidrocarburos">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:IngresosHidrocarburos"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/IngresosHidrocarburos10'"/>
              <xsl:with-param name="sl" select="'http://www.sat.gob.mx/sitio_internet/cfd/IngresosHidrocarburos10/IngresosHidrocarburos.xsd'"/>
              <xsl:with-param name="px" select="'ieeh'"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- ÚNICO VEHICULAR -->
          
          <xsl:if test="/fx:FactDocMX/fx:Complementos/fx:CUV">
            <xsl:call-template name="Complemento1">
              <xsl:with-param name="node" select="/fx:FactDocMX/fx:Complementos/fx:CUV"/>
              <xsl:with-param name="ns" select="'http://www.sat.gob.mx/UnicoVehicular10'"/>
              <xsl:with-param name="sl" select="'file:/C:/dev/mysuite/Fact8/release/xml/xsd/UnicoVehicular.xsd'"/>
              <xsl:with-param name="px" select="'unicoVehicular'"/>
            </xsl:call-template>
          </xsl:if>
          


        </cfdi:Complemento>
      </xsl:if>
    </cfdi:Comprobante>
  </xsl:template>

  <!-- ********************************* -->
  <xsl:template name="InstEducativas">
    <xsl:param name="node"/>
    <iedu:instEducativas xmlns:iedu="http://www.sat.gob.mx/iedu" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sat.gob.mx/iedu http://www.sat.gob.mx/sitio_internet/cfd/iedu/iedu.xsd">

      <xsl:attribute name="version">
        <xsl:value-of select="'1.0'"/>
      </xsl:attribute>

      <xsl:attribute name="nombreAlumno">
        <xsl:value-of select="$node/fx:NombreAlumno"/>
      </xsl:attribute>
      <xsl:attribute name="CURP">
        <xsl:value-of select="$node/fx:CURP"/>
      </xsl:attribute>
      <xsl:attribute name="nivelEducativo">
        <xsl:value-of select="$node/fx:NivelEducativo"/>
      </xsl:attribute>

      <xsl:attribute name="autRVOE">
        <xsl:value-of select="$node/fx:AutRVOE"/>
      </xsl:attribute>

      <xsl:if test="$node/fx:RfcPago">
        <xsl:attribute name="rfcPago">
          <xsl:value-of select="$node/fx:RfcPago"/>
        </xsl:attribute>
      </xsl:if>
    </iedu:instEducativas>
  </xsl:template>

  <xsl:template name="VentaVehiculos">
    <xsl:param name="node"/>

    <ventavehiculos:VentaVehiculos xmlns:ventavehiculos="http://www.sat.gob.mx/ventavehiculos" xsi:schemaLocation="http://www.sat.gob.mx/ventavehiculos http://www.sat.gob.mx/sitio_internet/cfd/ventavehiculos/ventavehiculos11.xsd">
      <xsl:attribute name="version">
        <xsl:value-of select="'1.1'"/>
      </xsl:attribute>

      <xsl:attribute name="ClaveVehicular">
        <xsl:value-of select="$node/fx:ClaveVehicular"/>
      </xsl:attribute>

      <xsl:attribute name="Niv">
        <xsl:value-of select="$node/fx:Niv"/>
      </xsl:attribute>


      <xsl:for-each select="$node/fx:DatosDeImportacion/fx:InformacionAduanera">
        <ventavehiculos:InformacionAduanera>

          <xsl:attribute name="numero">
            <xsl:value-of select="./fx:NumeroDePedimento"/>
          </xsl:attribute>

          <xsl:attribute name="fecha">
            <xsl:value-of select="./fx:FechaDePedimento"/>
          </xsl:attribute>

          <xsl:attribute name="aduana">
            <xsl:value-of select="./fx:NombreDeAduana"/>
          </xsl:attribute>

        </ventavehiculos:InformacionAduanera>

      </xsl:for-each>

    </ventavehiculos:VentaVehiculos>
  </xsl:template>

  <xsl:template name="PorCuentaDeTerceros">
    <xsl:param name="node"/>

    <terceros:PorCuentadeTerceros xmlns:terceros="http://www.sat.gob.mx/terceros" xsi:schemaLocation="http://www.sat.gob.mx/terceros        http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros11.xsd">
      <xsl:attribute name="version">
        <xsl:value-of select="'1.1'"/>
      </xsl:attribute>

      <xsl:attribute name="rfc">
        <xsl:value-of select="$node/fx:Rfc"/>
      </xsl:attribute>

      <xsl:if test="$node/fx:Nombre">
        <xsl:attribute name="nombre">
          <xsl:value-of select="$node/fx:Nombre"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$node/fx:InformacionFiscalTercero">
        <terceros:InformacionFiscalTercero>

          <xsl:attribute name="calle">
            <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Calle"/>
          </xsl:attribute>

          <xsl:if test="$node/fx:InformacionFiscalTercero/fx:NumeroExterior">
            <xsl:attribute name="noExterior">
              <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:NumeroExterior"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="$node/fx:InformacionFiscalTercero/fx:NumeroInterior">
            <xsl:attribute name="noInterior">
              <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:NumeroInterior"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="$node/fx:InformacionFiscalTercero/fx:Colonia">
            <xsl:attribute name="colonia">
              <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Colonia"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="$node/fx:InformacionFiscalTercero/fx:Localidad">
            <xsl:attribute name="localidad">
              <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Localidad"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="$node/fx:InformacionFiscalTercero/fx:Referencia">
            <xsl:attribute name="referencia">
              <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Referencia"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:attribute name="municipio">
            <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Municipio"/>
          </xsl:attribute>

          <xsl:attribute name="estado">
            <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Estado"/>
          </xsl:attribute>

          <xsl:attribute name="pais">
            <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:Pais"/>
          </xsl:attribute>

          <xsl:attribute name="codigoPostal">
            <xsl:value-of select="$node/fx:InformacionFiscalTercero/fx:CodigoPostal"/>
          </xsl:attribute>
        </terceros:InformacionFiscalTercero>
      </xsl:if>


      <!-- mys-808 eso solo toma la primera ocurrencia de 12 permitidas en el nativo, pero evita el error de esquema en el comprobante -->
      <!-- evidentemente esta mal -->
      <xsl:if test="$node/fx:DatosDeImportacion">
        <terceros:InformacionAduanera>
          <xsl:attribute name="numero">
            <xsl:value-of select="$node/fx:DatosDeImportacion/fx:InformacionAduanera/fx:NumeroDePedimento"/>
          </xsl:attribute>

          <xsl:attribute name="fecha">
            <xsl:value-of select="$node/fx:DatosDeImportacion/fx:InformacionAduanera/fx:FechaDePedimento"/>
          </xsl:attribute>

          <xsl:attribute name="aduana">
            <xsl:value-of select="$node/fx:DatosDeImportacion/fx:InformacionAduanera/fx:NombreDeAduana"/>
          </xsl:attribute>
        </terceros:InformacionAduanera>
      </xsl:if>

      <xsl:if test="$node/fx:CuentaPredial">
        <terceros:CuentaPredial>
          <xsl:attribute name="numero">
            <xsl:value-of select="$node/fx:CuentaPredial"/>
          </xsl:attribute>
        </terceros:CuentaPredial>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="$node/fx:Impuestos">
          <!-- no nos importa si meten locales, va a dar error en el codigo de impuesto -->
          <terceros:Impuestos>
            <xsl:variable name="countRetenciones" select="count($node/fx:Impuestos/fx:Impuesto[fx:Operacion = 'RETENCION'])"/>
            <xsl:variable name="countTraslados" select="count($node/fx:Impuestos/fx:Impuesto[fx:Operacion = 'TRASLADO'])"/>

            <xsl:if test="$countRetenciones > 0">
              <terceros:Retenciones>

                <xsl:for-each select="$node/fx:Impuestos/fx:Impuesto[fx:Operacion = 'RETENCION']">
                  <terceros:Retencion>
                    <xsl:attribute name="impuesto">
                      <xsl:value-of select="./fx:Codigo"/>
                    </xsl:attribute>
                    <xsl:attribute name="importe">
                      <xsl:value-of select="sum(./fx:Monto)"/>
                    </xsl:attribute>
                  </terceros:Retencion>
                </xsl:for-each>
              </terceros:Retenciones>
            </xsl:if>

            <xsl:if test="$countTraslados > 0">
              <terceros:Traslados>

                <xsl:for-each select="$node/fx:Impuestos/fx:Impuesto[fx:Operacion = 'TRASLADO']">
                  <terceros:Traslado>
                    <xsl:attribute name="impuesto">
                      <xsl:value-of select="./fx:Codigo"/>
                    </xsl:attribute>
                    <xsl:attribute name="tasa">
                      <xsl:value-of select="sum(./fx:Tasa)"/>
                    </xsl:attribute>
                    <xsl:attribute name="importe">
                      <xsl:value-of select="sum(./fx:Monto)"/>
                    </xsl:attribute>
                  </terceros:Traslado>
                </xsl:for-each>
              </terceros:Traslados>
            </xsl:if>
          </terceros:Impuestos>
        </xsl:when>
        <xsl:otherwise>
          <terceros:Impuestos/>
        </xsl:otherwise>
      </xsl:choose>

    </terceros:PorCuentadeTerceros>
  </xsl:template>

  <xsl:template name="LeyendasFiscales">
    <xsl:param name="node"/>
    <xsl:param name="ns"/>
    <xsl:param name="sl"/>
    <xsl:param name="px"/>
    <!-- LEYENDAS FISCALES -->

    <xsl:element name="{concat($px,':',local-name($node) )}" namespace="{$ns}">
      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="concat($ns, ' ', $sl)"/>
      </xsl:attribute>

      <xsl:attribute name="version">
        <xsl:value-of select="'1.0'"/>
      </xsl:attribute>

      <xsl:for-each select="$node/fx:Leyenda">
        <xsl:element name="{concat($px,':',local-name(.) )}" namespace="{$ns}">
          <!-- si no se pone namespace="{$ns}", la cosa tira xmlns="" efectivamente invalidando el elemento -->
          <xsl:if test="./fx:DisposicionFiscal">
            <xsl:attribute name="disposicionFiscal">
              <xsl:value-of select="./fx:DisposicionFiscal"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="./fx:Norma">
            <xsl:attribute name="norma">
              <xsl:value-of select="./fx:Norma"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:attribute name="textoLeyenda">
            <xsl:value-of select="./fx:TextoLeyenda"/>
          </xsl:attribute>
        </xsl:element>

      </xsl:for-each>

    </xsl:element>

  </xsl:template>

  <!-- COMPLEMENTOS A NIVEL COMPROBANTE: PLANTILLAS -->




  <xsl:template name="Complemento1">
    <xsl:param name="node"/>
    <xsl:param name="ns"/>
    <xsl:param name="sl"/>
    <xsl:param name="px"/>

    <!-- creamos el elemento raíz -->
    <xsl:element name="{concat($px,':',local-name($node) )}" namespace="{$ns}">
      
      <!-- agregamos schemaLocation -->
      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="concat($ns, ' ', $sl)"/>
      </xsl:attribute>
      <!-- xmlns: aparece por arte de magia -->
      
      <!-- copiamos los atributos que este elemento pueda tener o no -->
      <xsl:copy-of select="$node/@*"/>
  
      <!-- copiamos el valor del mismo elemento, si es que lo tenga -->
      <xsl:copy-of select="$node/text()"/>

      <!-- debemos de hacer lo mismo con los hijos, excepto de colocar schemaLocation -->
      <xsl:for-each select="$node/child::*">
        <xsl:call-template name="Complemento2">
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="px" select="$px"/>
          <xsl:with-param name="ns" select="$ns"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>


  <xsl:template name="Complemento2">
    <xsl:param name="node"/>
    <xsl:param name="px"/>
    <xsl:param name="ns"/>

    <!-- creamos el elemento -->
    <xsl:element name="{concat($px,':',local-name())}" namespace="{$ns}">
      
      <!-- copiamos sus atributos, si los hay -->
      <xsl:copy-of select="$node/@*"/>
      
      <!-- copiamos su valor si lo hay -->
      <xsl:copy-of select="$node/text()"/>
      
      <!-- lo mismo con hijos -->
      <xsl:for-each select="$node/child::*">
        <xsl:call-template name="Complemento2">
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="px" select="$px"/>
          <xsl:with-param name="ns" select="$ns"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  







  <xsl:template name="Complemento3">
    <xsl:param name="name"/>
    <xsl:param name="node"/>
    <xsl:param name="ns"/>
    <xsl:param name="sl"/>
    <xsl:param name="px"/>
    <!-- define ns arriba y lo tendrás arriba sin esfuerzo -->
    <xsl:element name="{concat($px,':',$name )}" namespace="{$ns}">
      <xsl:attribute name="xsi:schemaLocation">
        <xsl:value-of select="concat($ns, ' ', $sl)"/>
      </xsl:attribute>
      <xsl:copy-of select="$node/@*"/>
      <xsl:for-each select="$node/child::*">
        <xsl:call-template name="Complemento2">
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="px" select="$px"/>
          <xsl:with-param name="ns" select="$ns"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>


  <xsl:template name="Elemento1">
    <xsl:param name="node"/>
    <!-- define ns arriba y lo tendrás arriba sin esfuerzo -->
    <xsl:element name="{concat('cfdi:',local-name($node) )}" namespace="{'http://www.sat.gob.mx/cfd/3'}">
      
      <xsl:copy-of select="$node/@*"/>
      
      <xsl:for-each select="$node/child::*">
        <xsl:call-template name="Elemento2">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="Elemento2">
    <xsl:param name="node"/>
    <xsl:element name="{concat('cfdi:',local-name($node) )}" namespace="{'http://www.sat.gob.mx/cfd/3'}">
      
      <xsl:copy-of select="$node/@*"/>
      
      
      <xsl:for-each select="$node/child::*">
        <xsl:call-template name="Elemento2">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  















</xsl:stylesheet>
