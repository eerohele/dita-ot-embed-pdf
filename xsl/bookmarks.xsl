<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
  xmlns:local="urn:local-functions"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="local opentopic-index opentopic opentopic-func ot-placeholder">

  <xsl:template name="createBookmarks">
    <xsl:variable name="bookmarks" as="element()*">
      <xsl:choose>
        <xsl:when test="$retain-bookmap-order">
          <xsl:apply-templates select="/" mode="bookmark"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="/*/*[local:has-class(., 'topic/topic')]">
            <xsl:variable name="topicType">
              <xsl:call-template name="determineTopicType"/>
            </xsl:variable>
            <xsl:if test="$topicType = 'topicNotices'">
              <xsl:apply-templates select="." mode="bookmark"/>
            </xsl:if>
          </xsl:for-each>

          <xsl:choose>
            <xsl:when test="$map//*[local:has-class(., 'bookmap/toc')][@href]"/>
            <xsl:when test="$map//*[local:has-class(., 'bookmap/toc')]
                          | /*[local:has-class(., 'map/map')][not(local:has-class(., 'bookmap/bookmap'))]">
              <fo:bookmark internal-destination="{$id.toc}">
                <fo:bookmark-title>
                  <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Table of Contents'"/>
                  </xsl:call-template>
                </fo:bookmark-title>
              </fo:bookmark>
            </xsl:when>
          </xsl:choose>

          <xsl:for-each
            select="/*/*[local:has-class(., 'topic/topic')]
                  | /*/ot-placeholder:glossarylist
                  | /*/ot-placeholder:tablelist
                  | /*/ot-placeholder:figurelist
                  | /*/ot-placeholder:pdf">
            <xsl:variable name="topicType">
              <xsl:call-template name="determineTopicType"/>
            </xsl:variable>
            <xsl:if test="not($topicType = 'topicNotices')">
              <xsl:apply-templates select="." mode="bookmark"/>
            </xsl:if>
          </xsl:for-each>

          <xsl:if test="//opentopic-index:index.groups//opentopic-index:index.entry">
            <xsl:choose>
              <xsl:when test="$map//*[local:has-class(., 'bookmap/indexlist')][@href]"/>
              <xsl:when
                test="$map//*[local:has-class(., 'bookmap/indexlist')]
                    | /*[local:has-class(., 'map/map')][not(local:has-class(., 'bookmap/bookmap'))]">
                <fo:bookmark internal-destination="{$id.index}">
                  <fo:bookmark-title>
                    <xsl:call-template name="insertVariable">
                      <xsl:with-param name="theVariableID" select="'Index'"/>
                    </xsl:call-template>
                  </fo:bookmark-title>
                </fo:bookmark>
              </xsl:when>
            </xsl:choose>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="exists($bookmarks)">
      <fo:bookmark-tree>
        <xsl:copy-of select="$bookmarks"/>
      </fo:bookmark-tree>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ot-placeholder:pdf" mode="bookmark">
    <fo:bookmark>
      <xsl:if test="$bookmarkStyle ne 'EXPANDED'">
        <xsl:attribute name="starting-state">hide</xsl:attribute>
      </xsl:if>

      <xsl:attribute name="internal-destination">
        <xsl:call-template name="generate-toc-id"/>
      </xsl:attribute>

      <fo:bookmark-title>
        <xsl:value-of select="@navtitle"/>
      </fo:bookmark-title>
    </fo:bookmark>
  </xsl:template>

</xsl:stylesheet>
