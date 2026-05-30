import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function seedEo() {
    await prisma.event_organizer.createMany({
         data: [
            {
                EO_name: "EO 1",
                EO_Description: "EO ini punya Mydei",
                EO_Address: "Jl. EO 1 No. 123",
                EO_Price: 1000000,
                EO_Number: "081234567890",
                 EO_Rating: 4.5,
                },
                {
                    EO_name: "EO 2",
                    EO_Description: "EO ini punya Mydei",
                    EO_Address: "Jl. EO 2 No. 456",
                    EO_Price: 2000000,
                    EO_Number: "089876543210",
                    EO_Rating: 4.7,
                },
                {
                    EO_name: "EO 3",
                    EO_Description: "EO ini punya Mydei",
                    EO_Address: "Jl. EO 3 No. 789",
                    EO_Price: 1500000,
                    EO_Number: "087654321098",
                    EO_Rating: 5.0,
                }
                
            ]
        });
        console.log("EO data seeded successfully.");
}
