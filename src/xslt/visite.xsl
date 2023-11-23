<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : visite.xsl
    Created on : 7 novembre 2023, 15:50
    Author     : oukkaly
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:ci = "http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act = "http://www.ujf-grenoble.fr/l3miage/actes" >
    
    <xsl:output method="html"/>
    <!--paramètre global de l'id e l'infirmier -->
    <xsl:param name="destinedId" select="002"/>
    
    <!-- visiteDuJour nous permet de compter le nombre de patients propre a l'infirmiere  -->
    <xsl:variable name="visiteDuJour" select="count(//ci:patient/ci:visite[@intervenant=$destinedId])"/>
    
    
    
    <!-- actes permet de créer le pont entre ce fichier et le fichier actes.xml -->
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../CSS/cabinetInfirmier.css" />
                <script type="text/javascript">
                    function openFacture(prenom, nom, actes) {
                        var width  = 500;
                        var height = 300;
                        if(window.innerWidth) {
                        var left = (window.innerWidth-width)/2;
                        var top = (window.innerHeight-height)/2;
                        }
                        else {
                        var left = (document.body.clientWidth-width)/2;
                        var top = (document.body.clientHeight-height)/2;
                        }
                        var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                        factureText = "Facture pour : " + prenom + " " + nom + " " + actes;
                        factureWindow.document.write(factureText);
                    }
                </script>
                <title>visite.xsl</title>
            </head>
            <body>
                
                <!--page de l'infirmière-->
                <xsl:apply-templates select="//ci:infirmier[@id = $destinedId]"/>
                
                <h3>Liste de ses patients :</h3>
                <xsl:apply-templates select="//ci:patient[ci:visite[@intervenant=$destinedId]]" />
                <br/>
                
            </body>
        </html>
    </xsl:template>
    
    
    
    <xsl:template match="ci:infirmier">
        <h3 class="greetingInfirmier">Bonjour <xsl:value-of select="ci:prénom"/>,</h3>
        <p class="patientNumber">Aujourd'hui , vous avez <xsl:value-of select="$visiteDuJour" /> patients</p>  
    </xsl:template>
    
    
    
    <xsl:template match="ci:patient">
        <!-- idActePatient contient le numéro de l'id de l'acte dans le fichier cabinet  -->
        <xsl:variable name="idActePatient" select="ci:visite[@intervenant=$destinedId]/ci:acte/@id"/>
        <xsl:variable name="nomPatient" select="ci:nom"/>
        <xsl:variable name="textActesPatient" select="$actes/act:actes/act:acte[@id = $idActePatient]/text()"/>
        <br/>
        nom : <xsl:value-of select="ci:nom"/> 
        <xsl:value-of select="ci:prénom"/>
        <br/>
        adresse : <xsl:value-of select="ci:adresse/ci:numéro"/> 
        <xsl:value-of select="ci:adresse/ci:rue"/> 
        <xsl:value-of select="ci:adresse/ci:ville"/> 
        <xsl:value-of select="ci:adresse/ci:codePostal"/>
        <br/>
        soins a effectuer :
        <xsl:copy-of select="$textActesPatient" />
        <br/>
        
        <!-- _________________________________________________________________________________ 
        
        <input type="button">
            <xsl:attribute name="type">button</xsl:attribute>
            <xsl:attribute name="value">facture</xsl:attribute>
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="$destinedId"/>','<xsl:value-of select="$destinedId"/>','<xsl:value-of select="$destinedId"/>')
            </xsl:attribute>
        </input>
        
         <xsl:element name="input">
            <xsl:attribute name="type">button</xsl:attribute>
            <xsl:attribute name="value">Facture</xsl:attribute>
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="ci:prénom"/>', 
                            '<xsl:value-of select="ci:nom"/>', 
                            '<xsl:value-of select="$destinedId"/>')
            </xsl:attribute>
        </xsl:element>
        -->
        
<button class="button" type="button">
   <xsl:attribute name="onclick">
        openFacture(`<xsl:value-of select="ci:nom/text()"/>`,
        `<xsl:value-of select="ci:prénom/text()"/>`,
        `<xsl:value-of select="$textActesPatient"/>`)
    </xsl:attribute>
    facture
</button>
        
        <br/>
        <!-- -->
    </xsl:template>
    
    
   
</xsl:stylesheet>
