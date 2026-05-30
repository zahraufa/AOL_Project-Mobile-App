import {seedEo} from './seeds/eo.seed';
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();  

async function data() {
    try {
        await seedEo();

        console.log("All seed data inserted");
    } catch (error) {
        console.error(error);
    } finally {
        await prisma.$disconnect();
    }
}

data();