# 插件名称 

ftpartifact

# 功能说明

用于对产物文件归档到ftp服务器上

# 参数说明

| 参数名称 | 类型 | 默认值 | 是否必须 | 含义 |
|---|---|---|---|---|
| scm.type | string | git | **非必须** | 代码仓库类型，用于自动创建版本号时使用 |
| ftp.user | string | 空 | **非必须** | ftp相关信息 |
| ftp.pwd | string | 空 | **非必须** | ftp相关信息 |
| ftp.host | string | 空 | **非必须** | ftp相关信息 |
| ftp.port | string | 空 | **非必须** | ftp相关信息 |
| artifact.lane | string | dev | **必须** | 归档分区 |
| artifact.suffix | string | 空 | **必须** | 归档后缀 |
| group.id | string | 空 | **必须** | 归档组名称，会转化成目录 |
| artifact.id | string | 空 | **必须** | 归档名称 |
| artifact.version | string | 空 | **必须** | 归档版本 |
| fileset.dir | string | 空 | **必须** | 需要归档的文件所在目录 |
| fileset.includes | string | 空 | **必须** | 归档文件通配符 |
| fileset.excludes | string | 空 | **必须** | 归档排除文件通配符 |
| allow.redeploy | string | false | **必须** | 是否允许覆盖归档，默认是不允许 |
| is.create.checksum | boolean | true | **必须** | 是否创建md5文件，默认是创建 |

# 配置使用样例

```yml
stages:
- name: artifact
  tasks:
    - task.id: ftpartifact
      ftp.user: jenkins
      ftp.pwd: jenkins
      ftp.host: xxx.xxx.xyz
      ftp.port: 2120
      artifact.lane: qa
      group.id: xyz.opstack.jenkins.tasks
      artifact.id: hello
      artifact.version: 1.0.0
      fileset.dir: ${ws.dir}
      fileset.include: 'hello-*.tar.gz'
```