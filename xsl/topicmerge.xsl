<xsl:stylesheet version="2.0"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  exclude-result-prefixes="xs dita-ot">

  <xsl:import href="functions.xsl"/>

  <xsl:template priority="20" mode="build-tree"
    match="*[dita-ot:has-class(., 'map/topicref')][@format eq 'pdf']">
    <ot-placeholder:pdf href="{@href}">
      <xsl:apply-templates select="." mode="navtitle"/>
    </ot-placeholder:pdf>
  </xsl:template>

  <xsl:template mode="navtitle"
    match="*[dita-ot:has-class(., 'map/topicref')][@format eq 'pdf']">
    <xsl:attribute name="navtitle"
      select="(*[dita-ot:has-class(., 'map/topicmeta')]
              /*[dita-ot:has-class(., 'topic/navtitle')], @navtitle)[1]"/>
  </xsl:template>

</xsl:stylesheet>
