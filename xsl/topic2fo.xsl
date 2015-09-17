<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  xmlns:local="urn:local-functions"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="local ot-placeholder">

  <xsl:import href="functions.xsl"/>
  <xsl:import href="bookmarks.xsl"/>

  <xsl:template match="/" name="rootTemplate">
    <xsl:call-template name="validateTopicRefs"/>

    <!-- Add the FOP Extensions namespace into <fo:root>. -->
    <fo:root xsl:use-attribute-sets="__fo__root"
             xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">
      <xsl:call-template name="createLayoutMasters"/>
      <xsl:call-template name="createMetadata"/>
      <xsl:call-template name="createBookmarks"/>

      <xsl:apply-templates select="*" mode="generatePageSequences"/>
    </fo:root>
  </xsl:template>

  <xsl:template mode="generatePageSequences"
    match="*[local:has-class(., 'map/map')]">
    <xsl:next-match/>
    <xsl:apply-templates select="ot-placeholder:pdf"/>
  </xsl:template>

  <!--
  Embedding PDF documents in nested topics isn't currently supported.
  -->
  <xsl:template priority="1"
    match="*[local:has-class(., 'topic/topic')]/ot-placeholder:pdf">
   <xsl:call-template name="output-message">
     <xsl:with-param name="msgnum">001</xsl:with-param>
     <xsl:with-param name="msgsev">E</xsl:with-param>
     <xsl:with-param name="msgparams">%1=<xsl:value-of select="@href"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <xsl:template match="ot-placeholder:pdf">
    <xsl:apply-templates select="." mode="formatter">
      <xsl:with-param name="src" as="xs:anyURI"
        select="local:resolve-href(@href, $input.dir.url)"/>

      <xsl:with-param name="id" as="xs:string">
        <xsl:call-template name="generate-toc-id"/>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template mode="formatter"
    match="ot-placeholder:pdf[$pdfFormatter eq 'fop']">
    <xsl:param name="src" as="xs:anyURI"/>
    <xsl:param name="id" as="xs:string"/>

    <fox:external-document src="url('{$src}')" id="{$id}"/>
  </xsl:template>

  <xsl:template mode="formatter"
    match="ot-placeholder:pdf[$pdfFormatter eq 'ah']">
    <xsl:param name="src" as="xs:anyURI"/>
    <xsl:param name="id" as="xs:string"/>

    <fo:page-sequence id="{$id}"
      master-reference="body-sequence"
      axf:background-image="url('{$src}')"
      axf:background-repeat="paginate">
      <fo:flow flow-name="xsl-region-body"/>
    </fo:page-sequence>
  </xsl:template>

</xsl:stylesheet>
