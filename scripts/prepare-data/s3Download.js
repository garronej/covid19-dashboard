
const Minio = require("minio");
const { addParamToUrl } =require("powerhooks/tools/urlSearchParams");

async function getS3DownloadUrl(fileName) {

  const { AWS_S3_ENDPOINT, AWS_DEFAULT_REGION, AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY_ID, AWS_SESSION_TOKEN } = process.env;

  console.log(AWS_S3_ENDPOINT, AWS_DEFAULT_REGION, AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY_ID, AWS_SESSION_TOKEN);

  const minioClient = new Minio.Client({
    "endPoint": AWS_S3_ENDPOINT,
    "port": 443,
    "useSSL": true,
    "accessKey": AWS_ACCESS_KEY_ID,
    "secretKey": AWS_SECRET_ACCESS_KEY,
    "region": AWS_DEFAULT_REGION,
  });

  const bucketName = "jgarrone";
  const objectName = `dashboard_covid/${fileName}`;

  const downloadUrlWithoutSessionToken = await new Promise(
    (resolve, reject) => {
      minioClient.presignedGetObject(
        bucketName,
        objectName,
        3600, //One hour
        (err, url) => {
          if (err) {
            reject(err);
            return;
          }
          resolve(url);
        },
      );
    },
  );

  if (!AWS_SESSION_TOKEN) {
    console.log(downloadUrlWithoutSessionToken);
    return downloadUrlWithoutSessionToken;
  }

  const { newUrl: downloadUrl } = addParamToUrl({
    "url": downloadUrlWithoutSessionToken,
    "name": "X-Amz-Security-Token",
    "value": AWS_SESSION_TOKEN,
  });

  return downloadUrl;

}

module.exports= { getS3DownloadUrl };




