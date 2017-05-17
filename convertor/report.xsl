<?xm version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" />
    <xsl:param name="mode" />

    <xsl:variable name="process.root" select="@@CC_LAYER_PATH@@" />
    <xsl:variable name="base.url">@@BASE_URL@@</xsl:variable>
    <xsl:variable name="downfile.url">@@DOWNLOAD_URL@@</xsl:variable>
    <xsl:variable name="module.file">@@MODULE_FILE@@</xsl:variable>
    <xsl:variable name="page.layer.path">@@LAYER_PATH@@</xsl:variable>
    <xsl:variable name="isshowdetail">@@IS_SHOWDETAIL@@</xsl:variable>

    <xsl:key name="layer-by-name" match="@@CC_LAYER_PATH@@/layer" use="@name" />

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$mode = 'summary'">
                <xsl:apply-templates select="." mode="summary" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="task.layer" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template match="/" mode="summary">
        <xsl:if test="count($process.root//svnartifact) > 0">
            <xsl:call-template name="task.summary.sublayer"/>
        </xsl:if>
    </xsl:template>


    <xsl:template match="/" mode="task.layer">
        <xsl:if test="count($process.root//svnartifact) > 0">
            <h2 align="center">svnartifact report</h2>
            <xsl:call-template name="task.summary.sublayer" />
        </xsl:if>
        <xsl:if test="count($process.root//svnartifact) = 0 and count(//svnartifact) = 0">
            <p align="center">svnartifact was not run against this project. </p>
        </xsl:if>
    </xsl:template>


    <xsl:template match="*" mode="get.full.layer.name">
        <xsl:if test="count(parent::layer) > 0">
            <xsl:apply-templates select="parent::layer" mode="get.full.layer.name" />
        </xsl:if>
        <xsl:if test="local-name() = 'layer'">/<xsl:value-of select="@name" /></xsl:if>
    </xsl:template>

    <xsl:template name="task.summary.sublayer">
        <xsl:variable name="svnartifact.root" select="$process.root" />
        <xsl:variable name="child.layer.count" select="count($process.root/layer)" />

        <h2>&#160; SvnArtifact Summary <em><xsl:apply-templates select="$process.root[1]" mode="get.full.layer.name" /></em></h2>
        <table  class="sortable pane bigtable stripped-odd" id="svnartifact" border="1">
            <tbody>
                <tr class="header">
                    <th>
                        <xsl:if test="local-name($process.root[1]) = 'layer'">
                            <xsl:value-of select="$process.root[1]/@name" />
                        </xsl:if>
                        <xsl:if test="local-name($process.root[1]) != 'layer'">
                            Name
                        </xsl:if>
                    </th>
                    <th>ftp url</th>
                </tr>

                <xsl:if test="count($process.root) > 0">
                    <xsl:for-each select="$process.root">
                        <xsl:apply-templates select="svnartifact" mode="currentnode.task.layer" />
                    </xsl:for-each>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="svnartifact" mode="currentnode.task.layer">
        <tr>
            <td>./svnartifact</td>
            <td>
                <a><xsl:attribute name="href"><xsl:value-of select="ftp/@url" /></xsl:attribute><xsl:attribute name="target">_blank</xsl:attribute><xsl:value-of select="ftp/@url" /></a>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
