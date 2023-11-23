<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : visite.xsl
    Created on : 7 novembre 2023, 15:50
    Author     : oukkaly
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:ci = "http://www.ujf-grenoble.fr/l3miage/medical">
    <xsl:output method="html"/>
     <xsl:param name="destinedId" select="001"/>
     <xsl:variable name="visiteDuJour" select="count(//ci:patient/ci:visite[@intervenant=$destinedId])"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>visite.xsl</title>
            </head>
            <body>
                <xsl:apply-templates select="//ci:infirmier[@id = $destinedId]"/>
                <xsl:apply-templates select="//ci:patient/ci:visite[@intervenant=$destinedId]/.." />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ci:infirmier">
        <h3>Bonjour <xsl:value-of select="ci:prénom"/>,</h3>
        Aujourd'hui , vous avez <xsl:value-of select="$visiteDuJour" /> patients  
    </xsl:template>
    <xsl:template match="ci:pa">
</xsl:stylesheet>
