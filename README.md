# AWS-CI-CD-Pipeline-EC2-ECR
ทดสอบ local ก่อน push (แนะนำ)
npm install
npm start
# เปิด http://localhost:3000 ต้องเห็น JSON response


ถ้า local รันผ่าน ค่อย build Docker image ทดสอบอีกชั้น:
docker build -t my-app .
docker run -p 3000:3000 my-app
# เปิด http://localhost:3000 อีกรอบ



เช็คว่าทำขั้นตอน infra เสร็จครบหรือยัง
 สร้าง ECR repository แล้ว
 Launch EC2 + ติดตั้ง Docker แล้ว
 Attach IAM Role (ECR pull) ให้ EC2 แล้ว
 ติดตั้ง CodeDeploy Agent บน EC2 แล้ว
 Tag EC2 instance (เช่น Environment=demo) แล้ว
 สร้าง CodeDeploy Application + Deployment Group แล้ว