<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="tei" version="2.0">

    <xsl:output method="html" indent="yes" encoding="iso-8859-1" omit-xml-declaration="yes"/>

    <!-- "DINNER PARTY MENU" TEMPLATE. I USE THIS TO ORGANIZE THE BASIC STRUCTURE 
    OF THE OUTPUT DOCUMENT. SO IT WILL INCLUDE BASIC DOCUMENT STRUCTURE TAGS AND
    ANY PULLING/REORGANIZING OF INFORMATION FROM THE ORIGINAL.-->

    <xsl:template match="/"> <!-- NOTICE THE SLASH THERE. In XPath this means root node (which in a TEI XML file is <TEI>). -->
        <html>
            <body>
                <!-- a href=#to a specific point in a document -->
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>


    <!-- "FOOD PREP/MISE EN PLACE" TEMPLATES -->


   <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <xsl:template match="tei:teiHeader"/> 
    
    <!-- NOTICE THAT THIS ONE IS EMPTY. WE WILL TALK ABOUT WHAT THAT DOES.-->
    
    <xsl:template match="tei:head">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    
    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    
    <xsl:template match="tei:lg">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
 
 <!-- XSL TO MAKE LINKS TO NOTES -->
    <xsl:template match="tei:ref"><!--When you see a <ref>,-->
        <xsl:element name="a"><!--make <a> link-->
            <xsl:attribute name="href"><!--give it an attribute: href=-->
                <xsl:value-of select="@target"/><!--What does href=?  The value in the target.  (don't need to specify TEI in attributes)-->
            </xsl:attribute>
            *<!--This <a> needs something to wrap around so that there's something to click-->
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:person"><!--When you see a <person>,-->
        <xsl:element name="a"><!--make <a> link-->
            <xsl:attribute name="id"><!--give it an attribute: id=-->
                <xsl:value-of select="@xml:id"/><!--What does id=?  Whatever the xml:id is in that file.  (don't need to specify TEI in attributes)-->
        </xsl:attribute>
            <!--No text to wrap around because this is just a point-->
        </xsl:element>
        <h4><xsl:apply-templates select="tei:persName"/> (<xsl:apply-templates select="tei:birth"/>-<xsl:apply-templates select="tei:death"/>)</h4><!--In this h4 tag, we'll put just the name of this person (the child of this person called persname).  Then, we'll follow with birth and death years-->
        <!--<p>Occupation: <xsl:apply-templates select="tei:occupation"/></p>
        <p>Affiliation: <xsl:apply-templates select="tei:affiliation"/></p>-->
        
        <xsl:for-each select="tei:note">
            <p><xsl:apply-templates/></p>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="tei:object"><!--When you see an <object>,-->
        <xsl:element name="a"><!--make <a> link-->
            <xsl:attribute name="id"><!--give it an attribute: id=-->
                <xsl:value-of select="@xml:id"/><!--What does id=?  Whatever the xml:id is in that file.  (don't need to specify TEI in attributes)-->
            </xsl:attribute>
            <!--No text to wrap around because this is just a point-->
        </xsl:element>
        <h4><xsl:apply-templates select="tei:objectIdentifier"/></h4>
        <xsl:for-each select="tei:note">
            <p><xsl:apply-templates/></p>
        </xsl:for-each>

    </xsl:template>
 

<!--"RECIPE" TEMPLATES-->
    
    
<!-- A NAMED TEMPLATE THAT WILL HOLD INFORMATION/OUTPUT TO BE CALLED ELSEWHERE -->
    


</xsl:stylesheet>


