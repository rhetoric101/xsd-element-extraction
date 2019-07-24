<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xsl:template match="/">
  <html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd" MadCap:lastBlockDepth="2" MadCap:lastHeight="506" MadCap:lastWidth="576">
  <body>
  <h1>XML Elements Reference</h1>

    <!--Run through the Invoice elements -->
    <table style="border-style: solid;border-color: 666666;border-collapse: collapse">


      <thead>
        <tr>
          <th colspan="3" style="background-color: #ff8000;color: #ffffff">Invoice-Level Input XML Elements</th>
        </tr>
      </thead>
      <tbody >        
       <xsl:for-each select="/xs:schema/xs:complexType[@name = 'IndataInvoiceType']/xs:sequence/xs:element">      
         <!-- Get the Invoice parent element name --> 
         <tr style="background-color: #c0c0c0">
           <td colspan="3">
             <p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p>
           </td>
         </tr>
         <!-- Get the Invoice parent element Type -->
         <tr>
           <td colspan="3">
            <xsl:variable name="typeDetails" select="@type"/>
            <xsl:choose>
              <xsl:when test="xs:annotation">
                <p class="TableText">Type: <xsl:value-of select="@type"/></p>
              </xsl:when>
              <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction">
                <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction">
                  <xsl:choose>
                    <xsl:when test="@base='xs:long'">
                      <p class="TableText">Type: <xsl:value-of select="substring(@base,4)"/></p>
                    </xsl:when>
                    <xsl:when test="@base='xs:string'">
                      <p class="TableText">Type: <xsl:value-of select="substring(@base,4)"/></p>
                    </xsl:when>
                    <xsl:otherwise>
                      <p class="TableText">Type: <xsl:value-of select="@base"/></p>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>           
              </xsl:when>
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence">
                <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence">
                  <p class="TableText">Type: structural</p> 
                </xsl:for-each>             
              </xsl:when>
              <!--Test for cases like EXEMPT_AMOUNT-->
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all">
                <p class="TableText">Type: structural</p>                              
              </xsl:when>
              <xsl:otherwise>
                <p class="TableText">Type: n/a</p>           
              </xsl:otherwise>
            </xsl:choose> 
           </td>

 
         </tr>
         <!-- Get the Invoice parent element size -->
         <tr>
           <td colspan="3">
            <xsl:if test="not(xs:annotation/xs:restriction)">
             <xsl:variable name="typeDetails" select="@type"/> 
              <xsl:choose>
                <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction/xs:maxLength">
                  <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction/xs:maxLength">                    
                    <p class="TableText">Size: <xsl:value-of select="@value"/></p> 
                  </xsl:for-each>
                </xsl:when>                
                <xsl:otherwise>
                  <p class="TableText">Size: n/a</p>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
           </td>

         </tr> 
         <!--Parent: Indicate whether this element is required.-->
         <tr>
           <td colspan="3"><p class="TableText">Required: No</p></td>
         </tr>
         <!-- Get the Invoice parent element description -->
         <tr>  
           <td colspan="3">
           <xsl:variable name="typeDetails" select="@type"/>
            <xsl:choose>
              <xsl:when test="xs:annotation">
                <p class="TableText">Description: <xsl:value-of select="xs:annotation/xs:documentation"/></p>
              </xsl:when>
              <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]">
                <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]">
                  <p class="TableText">Description: <xsl:value-of select="xs:annotation/xs:documentation"/></p>
                </xsl:for-each>            
              </xsl:when>
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]">
                <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]">
                  <p class="TableText">Description: <xsl:value-of select="xs:annotation/xs:documentation"/></p> 
                </xsl:for-each>            
              </xsl:when>
              <xsl:otherwise>
                <p class="TableText">Description: n/a</p>
                  </xsl:otherwise>
            </xsl:choose>
           </td>
         </tr>

         <!-- Add the Invoice child element details, if they exist. -->
         <xsl:variable name="typeDetails" select="@type"/>
         <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]">          
          <xsl:if test="$typeDetails != 'IndataLineType'">            
                <xsl:choose>
                  <!--Option A: When there is "xs:all/xs:element" such as AmountType-->
                  <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all/xs:element">
                    <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all/xs:element">
                      <xsl:variable name="childTypeDetails" select="@type"/>

                      <!--Option A: Get the child name-->
                      <tr>               
                        <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                        <td style="background-color: #c0c0c0" colspan="2"><p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p></td>

                      </tr>                
                      <!--Child Option A: Get the child type-->
                      <tr >               
                        <td style="background-color: #c0c0c0" ><xsl:text>&#160;</xsl:text></td>
                        <td colspan="2"><p class="TableText">Type: <xsl:value-of select="@type"/></p></td>

                      </tr>
                      <!--Child Option A: Get the child size-->
                      <tr >               
                        <td style="background-color: #c0c0c0" ><xsl:text>&#160;</xsl:text></td>
                        <td colspan="2"><p class="TableText">Size: n/a</p></td>
                      </tr>
                      <!--Option A: Indicate whether this element is required.-->
                      <tr>
                        <td style="background-color: #c0c0c0" ><xsl:text>&#160;</xsl:text></td>
                        <td colspan="2"><p class="TableText">Required: No</p></td>
                      </tr>
                      <!--Child Option A: Get the child description-->                      
                      <tr >               
                        <td style="background-color: #c0c0c0" ><xsl:text>&#160;</xsl:text></td>
                        <td colspan="2"><p class="TableText">Description: <xsl:value-of select="xs:annotation"/></p></td>
                      </tr>                        
                      
                      
                      <!-- Grandchild Option A: /xs:schema/xs:complexType[@name = $childTypeDetails]/xs:all/xs:element -->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]">
                        <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]/xs:all/xs:element">
                          <!-- Get the grandchild name -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0">
                              <p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p>                                          
                            </td>
                          </tr> 
                          
                          <!-- Get the grandchild type -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td >
                              <p class="TableText">Type: <xsl:value-of select="@type"/></p>
                            </td>
                            
                          </tr>
                          <!-- Get the grandchild size -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td >
                              <p class="TableText">Size: n/a</p>
                            </td>
                          </tr>
                          <!--Indicate whether this element is required.-->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td><p class="TableText">Required: No</p></td>
                          </tr>
                          <!-- Get the grandchild description -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td><p class="TableText">Description: <xsl:value-of select="xs:annotation"/></p></td>
                          </tr>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:when>
                  <!--Child Option B: When there is "xs:sequence/xs:element"-->
                  <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element">
                    <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element">
                      <xsl:variable name="childTypeDetails" select="@type"/>
                      <!--Child Option B: Get the child name-->
                      <tr>               
                        <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                        <td style="background-color: #c0c0c0" colspan="2"><p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p></td>   
                      </tr>
                      <!--Child Option B: Get the child type-->
                      <xsl:choose>
                        <xsl:when test="@type='xs:string' and 'xs:long'">
                          <tr>               
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Type: <xsl:value-of select="substring(@type,4)"/></p></td>
                          </tr>
                        </xsl:when>                        
                        <xsl:when test="not(@type='xs:string' and 'xs:long')">
                          <tr>               
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Type: <xsl:value-of select="@type"/></p></td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr>               
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Type: structural</p></td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>                      
                      <!--Child Option B: Get the child size-->
                        <tr >               
                          <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                          <td colspan="2"><p class="TableText">Size: n/a</p></td>
                        </tr>
                      <!--Option B: Indicate whether this element is required.-->
                        <tr>
                          <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                          <td colspan="2"><p class="TableText">Required: No</p></td>
                        </tr>
                      
                      <!--Child Option B: Get the child description-->
                      <!-- When there is documentation in /xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation -->
                      <xsl:choose>
                        <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation">                          
                          <tr>               
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Description: <xsl:value-of select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation"/></p></td>
                          </tr>                                                    
                        </xsl:when>
                        <!-- When there is NO 
                          documentation in /xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element -->
                        <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element">                          
                          <tr>               
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Description: n/a</p></td>
                          </tr>                                                    
                        </xsl:when>
                        <xsl:otherwise><p class="TableText">Description: Child Option B Description "Otherwise"</p></xsl:otherwise>
                      </xsl:choose>

                      <!-- Grandchild Option B: /xs:schema/xs:complexType[@name = $childTypeDetails]/xs:sequence/xs:element -->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]">
                        <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]/xs:sequence/xs:element">
                          <!-- Get the grandchild B name -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0" >
                              <p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p>                                          
                            </td>
                          </tr> 
                          
                          <!-- Get the grandchild B type -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td >
                              <p class="TableText">Type: <xsl:value-of select="@type"/></p>
                            </td>
                            
                          </tr>
                          <!-- Get the grandchild B size -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td >
                              <p class="TableText">Size: n/a</p>
                            </td>
                          </tr>
                          <!-- Indicate whether this element is required.-->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td><p class="TableText">Required: No</p></td>
                          </tr>
                          <!-- Get the grandchild B description -->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td ><p class="TableText">Description: <xsl:value-of select="xs:annotation"/></p></td>
                          </tr>
                        </xsl:for-each>
                      </xsl:for-each>                       
                    </xsl:for-each>                    
                  </xsl:when>
                  <!--Child Option C: When there is "/xs:complexContent" such as BUYER_PRIMARY or TAX_TYPE-->
                  <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:complexContent">
                    <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:complexContent/xs:extension">
                      <xsl:variable name="childTypeBaseDetails" select="@base"/>                          

                      <!--Option C: Get the child Base name-->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeBaseDetails]/xs:sequence/xs:element">
                        <xsl:variable name="childTypeBaseDetails_2" select="@type"/>
                        <tr>               
                          <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                          <td style="background-color: #c0c0c0" colspan="2"><p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p></td>  
                        </tr> 
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]/xs:restriction">
                          <!--Option C: Get the child Base type-->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Type: <xsl:value-of select="substring(@base,4)"/></p></td>

                          </tr>
                          <!--Option C: Get the child Base size-->
                          <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]/xs:restriction/xs:maxLength">
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Size: <xsl:value-of select="@value"/></p></td>
                          </tr>
                          <!--Option C: Indicate whether this element is required.-->
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Required: No</p></td>
                          </tr>
                          </xsl:for-each>
                          <!--Option C: Get the child Base description-->
                          <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]">
                          <tr>
                            <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                            <td colspan="2"><p class="TableText">Description: <xsl:value-of select="xs:annotation"/></p></td>
                          </tr>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                        
                      <!--Option C: Get the child Extension data--> 
                      <xsl:for-each select="xs:sequence/xs:element">
                         <xsl:variable name="extensionDetails" select="@type"/>
                         <!--Option C: Get the child Extension data name-->
                         <tr>
                           <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                           <td style="background-color: #c0c0c0" colspan="2"><p class="TableText"><b>&lt;<xsl:value-of select="@name"/>&gt;</b></p></td>
                         </tr>
                      
                        <!--Option C: Get the child Extension data type-->
                         <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]/xs:restriction">                           
                           <tr> 
                             <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                             <td colspan="2"><p class="TableText">Type: <xsl:value-of select="substring(@base,4)"/></p></td>

                           </tr>
                         </xsl:for-each>
                        <!--Option C: Get the child Extension data size-->
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]/xs:restriction/xs:maxLength">
                           <tr>
                             <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                             <td colspan="2"><p class="TableText">Size: <xsl:value-of select="@value"/></p></td>

                           </tr>
                        </xsl:for-each>
                        <!--Option C: Indicate whether this element is required.-->
                        <tr>
                          <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                          <td colspan="2"><p class="TableText">Required: No</p></td>
                        </tr>
                           <!--Option C: Get the additional child Extension data documentation-->
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]">
                           <tr>
                             <td style="background-color: #c0c0c0"><xsl:text>&#160;</xsl:text></td>
                             <td colspan="2"><p class="TableText">Description: <xsl:value-of select="xs:annotation"/></p></td>

                           </tr>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each> 
                  </xsl:when>
                  <xsl:otherwise>
                    n/a
                  </xsl:otherwise>
                </xsl:choose>                    
                    
               
                    

            </xsl:if> 
         </xsl:for-each>  
          
         
       </xsl:for-each> <!-- Main For Each -->
      </tbody>                      
    </table>                
   
  </body>
 </html>
</xsl:template>
  
</xsl:stylesheet> 