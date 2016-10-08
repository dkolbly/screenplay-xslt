<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" version="1.0" indent="yes"/>

  <xsl:key name="location" match="glossary/location" use="@id" />
  <xsl:key name="char" match="glossary/character" use="@id" />
  <xsl:variable name="rev" select="screenplay/@rev"/>
  <xsl:variable name="date" select="screenplay/@date"/>
  
  <xsl:template match="screenplay">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
        <!-- US Letter -->
        <fo:simple-page-master page-height="279mm" page-width="216mm"
                               margin-left="5mm"
                               margin-right="5mm"
                               margin-top="0mm"
                               margin-bottom="0mm"
                               master-name="page">
          <fo:region-body margin-left="20mm"
                          margin-right="20mm"
                          margin-top="20mm"
                          margin-bottom="20mm"/>
          <fo:region-after extent="10mm" />
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="page">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block font-size="9pt"
                    text-align="center"
                    font-family="monospace">
            <fo:inline-container inline-progression-dimension="31%">
              <fo:block text-align="left">Rev. <fo:inline text-transform="uppercase"><xsl:value-of select="$rev"/></fo:inline> ; <xsl:value-of select="$date"/></fo:block>
            </fo:inline-container>
            <fo:inline-container inline-progression-dimension="31%">
              <fo:block />
            </fo:inline-container>
            <fo:inline-container inline-progression-dimension="31%">
              <fo:block text-align="right">p. <fo:page-number/> of <fo:page-number-citation ref-id="the-end"/></fo:block>
            </fo:inline-container>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates select="title"/>
          <fo:block font-size="12pt" font-family="RobotoMono">
            <xsl:apply-templates select="body"/>
            <fo:block id="the-end"/>
          </fo:block>
        </fo:flow>


      </fo:page-sequence>

      
    </fo:root>
  </xsl:template>

  <xsl:template match="title">
    <fo:block text-align="center" font-weight="bold" font-size="18pt">
      <xsl:apply-templates/>
    </fo:block>
    <fo:block text-align="center" font-size="12pt">
      Revision: <fo:inline text-transform="uppercase"><xsl:value-of select="$rev"/></fo:inline>
    </fo:block>
    <fo:block text-align="center" font-size="12pt">
      Date: <xsl:value-of select="$date"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="scene">
    <fo:block margin-top="4mm">
      <fo:block text-align="center">
        <fo:inline font-weight="bold">SCENE <xsl:call-template name="scene-number" /></fo:inline>
      </fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template name="scene-number">
    <xsl:choose>
      <xsl:when test="@id">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>(<xsl:value-of select="1+count(preceding-sibling::scene)" />)</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Handle <location ref="" /> -->
  <xsl:template match="location">
    <fo:block font-weight="bold"
              text-decoration="underline"
              margin-bottom="4mm">
      <xsl:for-each select="key('location', @ref)">
        <xsl:apply-templates/>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <!-- Handle <description>...</description> -->
  <xsl:template match="description">
    <fo:block font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <!-- Handle <subtitle>...</subtitle> -->
  <xsl:template match="subtitle">
    <fo:block text-align="center"
              font-style="italic"
              text-decoration="underline">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Handle <character ref="" /> -->
  <xsl:template match="character">
    <fo:block text-align="center"
              margin-top="4mm">
      <xsl:for-each select="key('char', @ref)">
        <fo:inline text-transform="uppercase">
          <xsl:apply-templates/>
        </fo:inline>
      </xsl:for-each>
      <xsl:choose>
        <xsl:when test="@style">
          <fo:inline> (<xsl:value-of select="@style" />)</fo:inline>
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
  <!-- Handle <paren>...</paren> -->
  <xsl:template match="paren">
    <fo:block font-style="italic"
              text-align="left"
              margin-left="44mm"
              margin-right="44mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Handle <dialog>...</dialog> -->
  <xsl:template match="dialog">
    <fo:block text-align="left"
              margin-left="32mm"
              margin-right="32mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
