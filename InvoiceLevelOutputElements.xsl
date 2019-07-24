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
      <col/>
      <col/>
      <col/>
      <col/>
      <col/>
      <col/>
      <thead>
        <tr>
          <th colspan="6" style="background-color: #ff8000;color: #ffffff">Invoice-Level Output XML Elements</th>
        </tr>
      </thead>
      <tbody >        
        <xsl:for-each select="/xs:schema/xs:complexType[@name = 'OutdataInvoiceType']/xs:sequence/xs:element">      
         <!-- Get the Invoice parent element name --> 
         <tr style="background-color: #c0c0c0">
           <td ><b>Element Name</b></td>
           <td colspan="5">
           <xsl:value-of select="@name"/>
           </td>
         </tr>
         <!-- Get the Invoice parent element Type -->
         <tr>
           <td>Type</td>
           <td colspan="5">
            <xsl:variable name="typeDetails" select="@type"/>
            <xsl:choose>
              <!--Test for ALLOCATION_LINE-->
              <xsl:when test="@name = 'ALLOCATION_LINE'">
                <xsl:text>structural</xsl:text>                              
              </xsl:when>
              <!--Test for xs:annotation-->
              <xsl:when test="xs:annotation">
                <xsl:value-of select="@type"/>
              </xsl:when>
              <!--Test for /xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction-->
              <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction">
                <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction">
                  <xsl:choose>
                    <xsl:when test="@base='xs:long'">
                      <xsl:value-of select="substring(@base,4)"/>
                    </xsl:when>
                    <xsl:when test="@base='xs:string'">
                      <xsl:value-of select="substring(@base,4)"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="@base"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>           
              </xsl:when>
              <!--Test for /xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence-->
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence">
                <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence">
                  <xsl:text>structural</xsl:text> 
                </xsl:for-each>             
              </xsl:when>
              <!--Test for cases like EXEMPT_AMOUNT-->
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all">
                  <xsl:text>structural</xsl:text>                              
              </xsl:when>

              <xsl:otherwise>
                <xsl:text>n/a</xsl:text>            
              </xsl:otherwise>
            </xsl:choose> 
           </td>
 
         </tr>
         <!-- Get the Invoice parent element size -->
         <tr>
           <td>Size</td>
           <td colspan="5">
            <xsl:if test="not(xs:annotation/xs:restriction)">
             <xsl:variable name="typeDetails" select="@type"/> 
              <xsl:choose>
                <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction/xs:maxLength">
                  <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]/xs:restriction/xs:maxLength">                    
                    <xsl:value-of select="@value"/> 
                  </xsl:for-each>
                </xsl:when>                
                <xsl:otherwise>
                 <xsl:text>n/a</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
           </td>
         </tr>         
         <!-- Get the Invoice parent element description -->
         <tr>  
           <td>Description</td>
           <td colspan="5">
           <xsl:variable name="typeDetails" select="@type"/>
            <xsl:choose>
              <xsl:when test="xs:annotation">
                <xsl:value-of select="xs:annotation/xs:documentation"/>
              </xsl:when>
              <xsl:when test="/xs:schema/xs:simpleType[@name = $typeDetails]">
                <xsl:for-each select="/xs:schema/xs:simpleType[@name = $typeDetails]">
                  <xsl:value-of select="xs:annotation/xs:documentation"/> 
                </xsl:for-each>            
              </xsl:when>
              <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]">
                <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]">
                  <xsl:value-of select="xs:annotation/xs:documentation"/> 
                </xsl:for-each>            
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>n/a</xsl:text>
                  </xsl:otherwise>
            </xsl:choose>
           </td>

         </tr>

         <!-- Add the Invoice child element details, if they exist. -->
         <xsl:variable name="typeDetails" select="@type"/>
         <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]">          

           <xsl:if test="$typeDetails != 'OutdataLineType' and $typeDetails != 'OutdataTaxSummaryType' and $typeDetails != 'IndataType'">            
                <xsl:choose>
                  <!--Option A: When there is "xs:all/xs:element" such as AmountType-->
                  <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all/xs:element">
                    <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:all/xs:element">
                      <xsl:variable name="childTypeDetails" select="@type"/>

                      <!--Option A: Get the child name-->
                      <tr>               
                        <td></td>
                        <td style="background-color: #ffcc99;color: #696969"><b>Child Name (Option A)</b></td>
                        <td style="background-color: #ffcc99;color: #696969" colspan="4"><xsl:value-of select="@name"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>                
                      <!--Child Option A: Get the child type-->
                      <tr >               
                        <td></td>
                        <td>Child Type (Option A)</td>
                        <td colspan="4"><xsl:value-of select="@type"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                      <!--Child Option A: Get the child size-->
                      <tr >               
                        <td></td>
                        <td>Child Size (Option A)</td>
                        <td colspan="4">n/a</td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                      <!--Child Option A: Get the child description-->                      
                      <tr >               
                        <td></td>
                        <td>Child Description(Option A)</td>
                        <td colspan="4"><xsl:value-of select="xs:annotation"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>                        
                      
                      
                      <!-- Grandchild Option A: /xs:schema/xs:complexType[@name = $childTypeDetails]/xs:all/xs:element -->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]">
                        <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]/xs:all/xs:element">
                          <!-- Get the grandchild name -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td style="background-color: #1f497d;color: #ffffff"><b>Grandchild Name (Option A)</b></td>
                            <td style="background-color: #1f497d;color: #ffffff" colspan="3">
                              <xsl:value-of select="@name"/>                                          
                            </td>
                          </tr> 
                          
                          <!-- Get the grandchild type -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Type</td>
                            <td colspan="3">
                              <xsl:value-of select="@type"/>
                            </td>
                            
                          </tr>
                          <!-- Get the grandchild size -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Size</td>
                            <td colspan="3">
                              <xsl:text>n/a</xsl:text>
                            </td>
                          </tr>
                          <!-- Get the grandchild description -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Description</td>
                            <td><xsl:value-of select="xs:annotation"/></td>
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
                          <td></td>
                          <td style="background-color: #ffcc99;color: #696969"><b>Child Name (Option B)</b></td>
                          <td style="background-color: #ffcc99;color: #696969" colspan="4"><xsl:value-of select="@name"/></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      <!--Child Option B: Get the child type-->
                      <xsl:choose>

                        <xsl:when test="@type='xs:string' and 'xs:long'">
                          <tr>               
                            <td></td>
                            <td>Child Type (Option By)</td>
                            <td colspan="4"><xsl:value-of select="substring(@type,4)"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                        </xsl:when>
                        
                        <xsl:when test="not(@type='xs:string' and 'xs:long')">
                          <tr>               
                            <td></td>
                            <td>Child Type (Option Byy)</td>
                            <td colspan="4"><xsl:value-of select="@type"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                        </xsl:when>
                        <xsl:otherwise>
                          <tr>               
                            <td></td>
                            <td>Child Type (Option Bx)</td>
                            <td colspan="4">Structural</td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                        </xsl:otherwise>
                      </xsl:choose>                      
                      <!--Child Option B: Get the child size-->
                        <tr >               
                          <td></td>
                          <td>Child Size (Option B)</td>
                            <td colspan="4">n/a</td>
                            <td></td>
                            <td></td>
                          <td></td>
                        </tr>
                      <!--Child Option B: Get the child description-->
                      <!-- When there is documentation in /xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation -->
                      <xsl:choose>
                        <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation">                          
                          <tr>               
                            <td></td>
                            <td>Child Option B Description(#1)</td>
                            <td colspan="4"><xsl:value-of select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:annotation"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>                                                    
                        </xsl:when>
                        <!-- When there is NO 
                          documentation in /xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element -->
                        <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:sequence/xs:element">                          
                          <tr>               
                            <td></td>
                            <td>Child Option B Description(#2)</td>
                            <td colspan="4">n/a</td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>                                                    
                        </xsl:when>
                        <xsl:otherwise>Child Option B Description "Otherwise"</xsl:otherwise>
                      </xsl:choose>

                      <!-- Grandchild Option B: /xs:schema/xs:complexType[@name = $childTypeDetails]/xs:sequence/xs:element -->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]">
                        <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeDetails]/xs:sequence/xs:element">
                          <!-- Get the grandchild name -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td style="background-color: #1f497d;color: #ffffff"><b>Grandchild Name (Option B)</b></td>
                            <td style="background-color: #1f497d;color: #ffffff" colspan="3">
                              <xsl:value-of select="@name"/>                                          
                            </td>
                          </tr> 
                          
                          <!-- Get the grandchild type -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Type</td>
                            <td colspan="3">
                              <xsl:value-of select="@type"/>
                            </td>
                            
                          </tr>
                          <!-- Get the grandchild size -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Size</td>
                            <td colspan="3">
                              <xsl:text>n/a</xsl:text>
                            </td>
                          </tr>
                          <!-- Get the grandchild description -->
                          <tr>
                            <td></td>
                            <td></td>
                            <td>Description</td>
                            <td><xsl:value-of select="xs:annotation"/></td>
                          </tr>
                        </xsl:for-each>
                      </xsl:for-each>
                       
                    </xsl:for-each>                    
                  </xsl:when>
                  <!--Child Option C: When there is "/xs:complexContent" such as BUYER_PRIMARY or TAX_TYPE-->
                  <xsl:when test="/xs:schema/xs:complexType[@name = $typeDetails]/xs:complexContent">
                    <xsl:for-each select="/xs:schema/xs:complexType[@name = $typeDetails]/xs:complexContent/xs:extension">
                      <xsl:variable name="childTypeBaseDetails" select="@base"/>
                      <p>Here is the value of childTypeBaseDetails:</p>
                      <xsl:value-of select="$childTypeBaseDetails"/>       

                      <!--Option C: Get the child Base name-->
                      <xsl:for-each select="/xs:schema/xs:complexType[@name = $childTypeBaseDetails]/xs:sequence/xs:element">
                        <xsl:variable name="childTypeBaseDetails_2" select="@type"/>
                        <tr>               
                          <td></td>
                          <td style="background-color: #ffcc99;color: #696969"><b>Child Base Name (Option C)</b></td>
                          <td style="background-color: #ffcc99;color: #696969" colspan="4"><xsl:value-of select="@name"/></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>                
                        <p>Here is the value of childTypeBaseDetails_2:</p>
                        <xsl:value-of select="$childTypeBaseDetails_2"/>
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]/xs:restriction">
                          <!--Option C: Get the child Base type-->
                          <tr>
                            <td></td>
                            <td >Child Base Type (Option Cz)</td>
                            <td colspan="4"><xsl:value-of select="substring(@base,4)"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                          <!--Option C: Get the child Base size-->
                          <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]/xs:restriction/xs:maxLength">
                          <tr>
                            <td></td>
                            <td >Child Base Size (Option Cx)</td>
                            <td colspan="4"><xsl:value-of select="@value"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                          </xsl:for-each>
                          <!--Option C: Get the child Base description-->
                          <xsl:for-each select="/xs:schema/xs:simpleType[@name = $childTypeBaseDetails_2]">
                          <tr>
                            <td></td>
                            <td >Child Base Description (Option C)</td>
                            <td colspan="4"><xsl:value-of select="xs:annotation"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                        
                      <!--Option C: Get the child Extension data--> 
                      <xsl:for-each select="xs:sequence/xs:element">
                         <xsl:variable name="extensionDetails" select="@type"/>
                         <!--Option C: Get the child Extension data name-->
                         <tr>
                           <td></td>
                           <td style="background-color: #ffcc99;color: #696969"><b>Child Extension Name (Option C)</b></td>
                           <td style="background-color: #ffcc99;color: #696969" colspan="4"><xsl:value-of select="@name"/></td>
                           <td></td>
                           <td></td>
                           <td></td>
                         </tr>
                        <p>Here is the value of extensionDetails:</p>
                        <xsl:value-of select="$extensionDetails"/>
                        <!--Option C: Get the child Extension data type-->
                         <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]/xs:restriction">                           
                           <tr> 
                            <td></td>
                            <td >Child Extension Type (Option C)</td>
                            <td colspan="4"><xsl:value-of select="substring(@base,4)"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                           </tr>
                         </xsl:for-each>
                        <!--Option C: Get the child Extension data size-->
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]/xs:restriction/xs:maxLength">
                           <tr>
                            <td></td>
                             <td >Child Extension Size (Option C)</td>
                            <td colspan="4"><xsl:value-of select="@value"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                           </tr>
                        </xsl:for-each>
                           <!--Option C: Get the additional child Extension data documentation-->
                        <xsl:for-each select="/xs:schema/xs:simpleType[@name=$extensionDetails]">
                           <tr>
                            <td></td>
                            <td>Child Extension Doc (Option C)</td>
                            <td colspan="4"><xsl:value-of select="xs:annotation"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
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