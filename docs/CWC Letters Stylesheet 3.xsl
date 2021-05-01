<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="tei" version="2.0">

    <xsl:output method="html" indent="yes" encoding="iso-8859-1" omit-xml-declaration="yes"/>

    <!--  ORGANIZE THE BASIC STRUCTURE OF THE OUTPUT DOCUMENT. BASIC DOCUMENT STRUCTURE TAGS AND ANY PULLING/REORGANIZING OF INFORMATION FROM THE ORIGINAL.-->

    <xsl:template match="/"> 
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="chesnutt878.css"/>
                <title>Charles W. Chesnutt Publishers Correspondence</title>
            </head>
            <body>
                <h1 class="banner">Charles W. Chesnutt Publisher Correspondence</h1>
                <h2 class="banner">A DH Archival Project for ENGL878</h2>
                <br/>
                <h3><xsl:apply-templates select="//tei:titleStmt/tei:title"/></h3> 
                <xsl:apply-templates/> 
                <p>See the source <a href="">XML</a>, <a href="">XSLT</a>, and <a href="">CSS.</a>  (Note that the XML, XSLT, and CSS file types will not display well in a browser.  Right click each link to save the files to the computer for closer reading.)</p><!-- link to file in the same folder as href attribute-->
            </body>
        </html>
    </xsl:template>


    <!-- XSLT TO HANDLE ALL SORTS OF SMALL, STRUCTURAL TRANSFORMATIONS -->
    
    <xsl:template match="tei:teiHeader"/>
  
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:head">
        <h1 class="letter">
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    
    <xsl:template match="tei:lb">
            <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="tei:fw">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:addrLine">
        <p>
            <xsl:apply-templates/>
        </p> 
    </xsl:template>
    
    <xsl:template match="tei:dateline">
        <p>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:salute">
        <br/>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:signed">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <!-- XSLT TO HANDLE ALL SORTS OF TEXT, DESIGN-Y, MANUSCRIPT ENCODING TRANSFORMATIONS -->
    <!--<xsl:template match="hi">
        <xsl:choose>
            <xsl:when test="./attribute::rend='superscript'">
                <sup><xsl:apply-templates/></sup>
            </xsl:when>
            <xsl:when test="./attribute::rend='italic'">
                <i><xsl:apply-templates/></i>
            </xsl:when>
            <xsl:when test="./attribute::rend='underline'">
                <u><xsl:apply-templates/></u>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->
    
    <xsl:template match="tei:hi">
        <xsl:choose>            
            <xsl:when test="contains(@rend, 'underline')">
                <span class="u">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="contains(@rend, 'italic')">
                <span class="i">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <span class="del">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:add">
        <span class="add">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    
 
 <!-- XSL TO MAKE LINKS TO STANDOFF AND NOTES -->
    <xsl:template match="tei:ref">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            *
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <xsl:element name="a">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
        </xsl:attribute>
        </xsl:element>
        <h4><xsl:apply-templates select="tei:persName"/> (<xsl:apply-templates select="tei:birth"/>-<xsl:apply-templates select="tei:death"/>)</h4>
        
        <xsl:for-each select="tei:note">
            <p><xsl:apply-templates/></p>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="tei:object">
        <xsl:element name="a">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:element>
        <h4><xsl:apply-templates select="tei:objectIdentifier"/></h4>
        <xsl:for-each select="tei:note">
            <p><xsl:apply-templates/></p>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- XSL TO MAKE THUMBNAILS AND IMAGES -->
    
    <xsl:template match="tei:pb">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('full/', @facs)"></xsl:value-of>
            </xsl:attribute>
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="concat('thumbs/', @facs)"/>
            </xsl:attribute>
        </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    
    
    <!-- XSL TO WRAP ALL THE HANDS TO MAKE THEM WORK IN CSS -->   
    <xsl:template match="tei:note">
        <xsl:choose>            
            <xsl:when test="contains(@hand, '#h01')">
                <span class="unknownPrintedType">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="contains(@hand, '#h02')">
                <span class="cwcType">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="contains(@hand, '#h03')">
                <span class="cwcInk">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="contains(@hand, '#h04')">
                <span class="unknownPencil">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>

            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <!-- TEMPLATE FOR <PB>S
    <xsl:template match="tei:pb">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>-->
 
<!--"RECIPE" TEMPLATES-->
    
    
<!-- A NAMED TEMPLATE THAT WILL HOLD INFORMATION/OUTPUT TO BE CALLED ELSEWHERE -->
    


</xsl:stylesheet>


