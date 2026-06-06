import { PrismaClient } from "@prisma/client";

export async function seedEo(prisma: PrismaClient) {
    const daftarKategori = ['Wedding Event', 'Corporate Event', 'Birthday Party', 'Seminar'];
    const dbCategories: Record<string, any> = {};
    for (const category of daftarKategori) {
        dbCategories[category] = await prisma.eo_category.upsert({
            where: { Category_Name: category },
            update: {},
            create: { Category_Name: category },
        });
    }

    const daftarService = [
        'Rundown and Scriptwriting',
        'Master of Ceremony (MC)',
        'Tim Dokumentasi dan Fotografi',
        'Guest Management',
        'Show Controlling',
        'Jasa Live Streaming',
        'Decoration & Invitation Design',
        'Photobooth',
        'Live Painting',
        'Performer'   
    ]
    const dbServices: Record<string, any> = {};
    for (const service of daftarService) {
        dbServices[service] = await prisma.services.upsert({
            where: { Service_name: service },
            update: {},
            create: { Service_name: service },
        });
    }

    const dataSemuaEO = [
        {
            EO_Name: "Jakarta Event Organizer",
            EO_Description: "Event Organizer profesional di Jakarta dengan pengalaman lebih dari 10 tahun dalam mengelola berbagai jenis acara.",
            EO_Address: "Jl. Swadaya No. 123",
            EO_Number: "081234567890",
            EO_Rating: 4.5,

            categories: ['Wedding Event'],
      
            packages: [
                { Name: "Silver Wedding", Price: 15000000, Desc: "Standard dekor & MC" },
                { Name: "Gold Wedding", Price: 30000000, Desc: "Mewah dekor & Catering" }
            ],
            
            services: [
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

                //ini add-ons
                { name: 'Photobooth', price: 2000000, required: false, desc: 'Kuota cetak sepuasnya selama 3 jam' },
                { name: 'Jasa Live Streaming', price: 3500000, required: false, desc: 'Live ke YouTube / Zoom dengan 3 kamera' }
            ]
        },
        {
            EO_Name: "Widya Event Organizer",
            EO_Description: "We're here to serve and mwah",
            EO_Address: "Jl. Kartini No. 33",
            EO_Number: "0899827663",
            EO_Rating: 5.0,

            categories: ['Birthday Party'],
      
            packages: [
                { Name: "Sweet Seventeen", Price: 13000000, Desc: "Floral deco, Freebies & MC" },
            ],
            
            services: [
                //ini tetap
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

                //ini add-ons
                { name: 'Photobooth', price: 2000000, required: false, desc: 'Kuota cetak sepuasnya selama 3 jam' },
                { name: 'Decoration & Invitation Design', price: 500000, required: false, desc: 'Desain undangan sesuai tema acara' },
                { name: 'Performer', price: 10000000, required: false, desc: 'DJ' }
            ]
        },

        {
            EO_Name: "Okhaema EO", 
            EO_Description: "EO spesialis acara konser dan corporate dengan pengalaman lebih dari 15 tahun dalam mengelola event skala besar di Indonesia.",
            EO_Address: "Jl. Bubur No. 156",
            EO_Number: "0887659981",
            EO_Rating: 4.9,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Seminar', 'Corporate Event'],
            
            packages: [
                { Name: "Silver Corporate Package", Price: 40000000, Desc: "Paket standard untuk gathering perusahaan internal." },
                { Name: "Gold Festival Package", Price: 95000000, Desc: "Paket skala besar untuk panggung konser outdoor luar ruangan." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Performer', price: 15000000, required: false, desc: 'Penyediaan talent band atau pengisi acara hiburan lokal.' },
                { name: 'Live Painting', price: 5000000, required: false, desc: 'Dokumentasi artistik berupa lukisan langsung selama acara festival.' }
      ]
    }
    // {
    //         EO_Name: "Groovy", 
    //         EO_Description: "Groovy Event Organizer (EO) terbaik di Jakarta, Indonesia, memberikan layanan one stop solution untuk berbagai jenis acara indoor dan outdoor. Dengan pengalaman sejak 2007, Groovy EO menyediakan layanan profesional untuk launching, gathering, conference, seminar, townhall, exhibition, dan roadshow yang dirancang khusus dan menarik sesuai kebutuhan klien.",
    //         EO_Address: "Jl. Batu Ceper IV",
    //         EO_Number: " 081284858608",
    //         EO_Rating: 5.0,

    //         // Menggunakan master data kategorimu agar tidak undefined saat di-seed
    //         categories: ['Wedding Event', 'Seminar'],
            
    //         packages: [
    //             { Name: "Silver Corporate Package", Price: 40000000, Desc: "Paket standard untuk gathering perusahaan internal." },
    //             { Name: "Gold Festival Package", Price: 95000000, Desc: "Paket skala besar untuk panggung konser outdoor luar ruangan." }
    //         ],
            
    //         services: [
                
    //             { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
    //             { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
    //             { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
    //             { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
    //             { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
    //             { name: 'Performer', price: 15000000, required: false, desc: 'Penyediaan talent band atau pengisi acara hiburan lokal.' },
    //             { name: 'Live Painting', price: 5000000, required: false, desc: 'Dokumentasi artistik berupa lukisan langsung selama acara festival.' }
    //   ]
        
    ];

    for(const eoData of dataSemuaEO) {
        await prisma.event_organizer.create({
            data:{
               EO_name: eoData.EO_Name,
                EO_Description: eoData.EO_Description,
                EO_Address: eoData.EO_Address,
                EO_Number: eoData.EO_Number,
                EO_Rating: eoData.EO_Rating,
        
            eo_package: {
            create: eoData.packages.map(p => ({
                Package_Name: p.Name,
                Package_Price: p.Price,
                Package_Description: p.Desc
          }))
        }, 
            event_organizer_categories: {
            create: eoData.categories.map(catName => ({
                Category_ID: dbCategories[catName].Category_ID
            }))
        },

            event_organizer_services: {
          create: eoData.services.map(s => ({
            Main_Services_ID: dbServices[s.name].Service_ID,
            Service_Price: s.price,
            Service_Description: s.desc
          }))
        }

    }
});
}
    console.log("EO data seeded successfully.");
}
