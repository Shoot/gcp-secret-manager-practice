# Copyright 2021 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

GOOGLE_PROJECT_ID=gcp-secret-manager-practice
CLOUD_RUN_SERVICE=gcp-secret-manager-practice
INSTANCE_CONNECTION_NAME=gcp-secret-manager-practice:europe-southwest1:mysql-instance
DB_USER=app
DB_NAME=dogs-db

gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT_ID/$CLOUD_RUN_SERVICE \
  --project=$GOOGLE_PROJECT_ID

gcloud run deploy $CLOUD_RUN_SERVICE \
  --image gcr.io/$GOOGLE_PROJECT_ID/$CLOUD_RUN_SERVICE \
  --add-cloudsql-instances $INSTANCE_CONNECTION_NAME \
  --update-env-vars INSTANCE_CONNECTION_NAME=$INSTANCE_CONNECTION_NAME,DB_USER=$DB_USER,DB_NAME=$DB_NAME,GOOGLE_PROJECT_ID=$GOOGLE_PROJECT_ID \
  --service-account=gcp-secret-manager-practice@gcp-secret-manager-practice.iam.gserviceaccount.com \
  --platform managed \
  --region europe-southwest1 \
  --allow-unauthenticated \
  --project=$GOOGLE_PROJECT_ID
