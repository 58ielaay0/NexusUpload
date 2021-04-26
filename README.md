# NexusUpload

This is a Github action which upload files on a raw directory on a Nexus server.

### Inputs (all mandatory):
- env :
  - NEXUS_USER : username to use for the upload to the Nexus server
  - NEXUS_PASSWORD : password to use for the upload to the Nexus server
- with :
  - NexusURL : the base url of the Nexus server
  - Repository : the name of the repository where the file will be uploaded
  - RepositoryDirectory : the directory (component group) of the repository where the file will be uploaded
  - FileToUpload : the path of the file to upload

### Example in the github action :

```yaml
- id: packageUpload
  name: Upload package to Nexus
  uses: 58ielaay0/NexusUpload@v0.1
  env:
    NEXUS_USER: ${{ secrets.NEXUS_USER }}
    NEXUS_PASSWORD: ${{ secrets.NEXUS_PASSWORD }}
  with:
    NexusURL: 'https://nexus.test.com'
    Repository: 'raw'
    RepositoryDirectory: 'test'
    FileToUpload: '.\test.zip'
```
