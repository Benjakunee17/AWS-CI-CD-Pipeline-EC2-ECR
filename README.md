# AWS-CI-CD-Pipeline-EC2-ECR
ทดสอบ local ก่อน push (แนะนำ)
npm install
npm start
# เปิด http://localhost:3000 ต้องเห็น JSON response


ถ้า local รันผ่าน ค่อย build Docker image ทดสอบอีกชั้น:
docker build -t my-app .
docker run -p 3000:3000 my-app
# เปิด http://localhost:3000 อีกรอบ