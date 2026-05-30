import { PrismaClient } from "@prisma/client"

const prisma = new PrismaClient()

async function main() {
  await prisma.event_organizer.createMany({
    data: [
     {
      EO_ID: 1,
      EO_name: "Dream Wedding Organizer",
      EO_Description: "Spesialis acara pernikahan modern dan tradisional.",
      EO_Address: "Jl. Asia Afrika No. 12, Bandung",
      EO_Price: 15000000,
      EO_Number: "081234567890",
      EO_Rating: 4.8
     },
     {
      EO_ID: 2,
      EO_name: "Spark Event Planner",
      EO_Description: "Melayani seminar, gathering, dan corporate event.",
      EO_Address: "Jl. Sudirman No. 45, Jakarta",
      EO_Price: 10000000,
      EO_Number: "082345678901",
      EO_Rating: 4.5
     },
     {
      EO_ID: 3,
      EO_name: "Golden Moment EO",
      EO_Description: "Paket lengkap wedding organizer premium.",
      EO_Address: "Jl. Diponegoro No. 18, Bandung",
      EO_Price: 20000000,
      EO_Number: "083456789012",
      EO_Rating: 4.9
     },
    ]
  })
}

main()
  .catch(console.error)
  .finally(async () => {
    await prisma.$disconnect()
  })