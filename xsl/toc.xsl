<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  xmlns:local="urn:local-functions"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="local xs ot-placeholder">

  <xsl:template match="ot-placeholder:pdf[local:in-toc(.)]" mode="toc">
    <fo:block xsl:use-attribute-sets="__toc__indent">
      <fo:basic-link xsl:use-attribute-sets="__toc__link">
        <xsl:attribute name="internal-destination">
          <xsl:call-template name="generate-toc-id"/>
        </xsl:attribute>

        <xsl:apply-templates select="." mode="tocPrefix"/>

        <fo:inline xsl:use-attribute-sets="__toc__title">
          <xsl:value-of select="@navtitle"/>
        </fo:inline>

        <fo:inline xsl:use-attribute-sets="__toc__page-number">
          <fo:leader xsl:use-attribute-sets="__toc__leader"/>
          <fo:page-number-citation>
            <xsl:attribute name="ref-id">
              <xsl:call-template name="generate-toc-id"/>
            </xsl:attribute>
          </fo:page-number-citation>
        </fo:inline>
      </fo:basic-link>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
