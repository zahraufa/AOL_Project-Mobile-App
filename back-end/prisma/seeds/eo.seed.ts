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
    },
    {
            EO_Name: "Groovy", 
            EO_Description: "Groovy Event Organizer (EO) terbaik di Jakarta, Indonesia, memberikan layanan one stop solution untuk berbagai jenis acara indoor dan outdoor. Dengan pengalaman sejak 2007, Groovy EO menyediakan layanan profesional untuk launching, gathering, conference, seminar, townhall, exhibition, dan roadshow yang dirancang khusus dan menarik sesuai kebutuhan klien.",
            EO_Address: "Jl. Batu Ceper IV",
            EO_Number: " 081284858608",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Seminar'],
            
            packages: [
                { Name: "Groovy Silver Gathering", Price: 25000000, Desc: "Paket standard seminar / intimate event indoor up to 100 pax." },
                { Name: "Groovy Platinum Corporate", Price: 65000000, Desc: "Paket lengkap corporate launching & seminar besar up to 500 pax." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Performer', price: 20000000, required: false, desc: 'Penyediaan talent pengisi acara / live band lokal ternama.' },
                { name: 'Jasa Live Streaming', price: 6000000, required: false, desc: 'Live broadcast ke YouTube/Zoom dengan sistem 3 kamera.' }
      ]
    },
    {
            EO_Name: "Stellar Event Organizer", 
            EO_Description: "From planning to execution, we craft exceptional corporate events tailored to your needs.",
            EO_Address: "Gedung Wirausaha Lantai 1, Jalan HR Rasuna Said Kav. C-5, Karet, Setia Budi, Jakarta Selatan 12920",
            EO_Number: " 087780080570",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Seminar', 'Corporate Event'],
            
            packages: [
                { Name: "Stellar Executive Summit", Price: 45000000, Desc: "Paket konferensi premium termasuk sewa ballroom dan hospitality." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Decoration & Invitation Design', price: 15000000, required: false, desc: 'Kustomisasi full dekorasi panggung eksklusif bertema korporat.' },
                { name: 'Photobooth', price: 3500000, required: false, desc: 'Fasilitas photobooth cetak instan sepuasnya untuk kenang-kenangan tamu.' }
      ]
    },
    {
            EO_Name: "Creo", 
            EO_Description: "From heartfelt weddings to high-stake corporate events, Creo turns your vision into a seamless experience.",
            EO_Address: "Jalan. Jakarta Selatan No. 45, Jakarta Selatan, Indonesia",
            EO_Number: " 081233989978",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Seminar', 'Corporate Event'],
            
            packages: [
                { Name: "Creo Basic Wedding", Price: 30000000, Desc: "Paket pernikahan esensial untuk perayaan sakral bernuansa hangat." },
                { Name: "Creo Royal Wedding Pack", Price: 85000000, Desc: "Paket pernikahan megah ala istana dengan pelayanan komprehensif." },
                { Name: "Creo Business Launch", Price: 50000000, Desc: "Paket khusus peresmian kantor baru atau peluncuran produk korporat." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Live Painting', price: 8000000, required: false, desc: 'Live painting oleh pelukis profesional mengabadikan momen utama di atas kanvas.' },
                { name: 'Jasa Live Streaming', price: 4500000, required: false, desc: 'Streaming multi-platform resolusi tinggi dengan dedicated internet backup.' }
      ]
    },
    {
            EO_Name: "Prisma Multimedia", 
            EO_Description: "Menghadirkan Standar Baru Event Organizer Terbaik",
            EO_Address: "Conclave Simatupang Jl. Raya Cilandak KKO No. 410, Pasar Minggu, Jakarta 12560",
            EO_Number: " 081313130660",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Seminar', 'Corporate Event'],
            
            packages: [
                { Name: "Prisma Gathering Package", Price: 38000000, Desc: "Paket multimedia gathering lengkap dengan giant LED Screen." },
                { Name: "Prisma Wedding Premium", Price: 70000000, Desc: "Paket pernikahan mewah dengan dokumentasi cinematic berstandar tinggi." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Performer', price: 18000000, required: false, desc: 'Penyediaan live band akustik / modern jazz untuk mengiringi jalannya acara.' },
                { name: 'Photobooth', price: 3000000, required: false, desc: 'Fasilitas photobooth cetak cepat menggunakan teknologi cetak thermal modern.' }
      ]
    },
    {
            EO_Name: "eventy.id", 
            EO_Description: "Innovation Event Through Technology",
            EO_Address: "Jalan Bina Remaja No.6, Banyumanik, Kota Semarang, Jawa Tengah 50268",
            EO_Number: "081227645880",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Corporate Event'],
            
            packages: [
                { Name: "Tech Event Solution", Price: 55000000, Desc: "Paket pameran atau expo dibantu integrasi teknologi registrasi canggih." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Jasa Live Streaming', price: 5000000, required: false, desc: 'Sistem live streaming multicam interaktif terintegrasi layar panggung utama.' },
                { name: 'Decoration & Invitation Design', price: 12000000, required: false, desc: 'Pembuatan desain panggung bertema futuristik dan instalasi gate modern.' }
      ]    
    },
        {
            EO_Name: "Mirs Drone Show", 
            EO_Description: "Premium drone light shows for brand activations, Independence Day (HUTRI), wedding celebrations and corporate launches - across Jakarta, Bali, Surabaya and beyond. Fully DGCA-compliant, transparent pricing.",
            EO_Address: "3. Singapore Headquaters: Little Road #03-01, Cemtex Industrial Building, Singapore 536983",
            EO_Number: "6596787454",
            EO_Rating: 5.0,

            // Menggunakan master data kategorimu agar tidak undefined saat di-seed
            categories: ['Wedding Event', 'Seminar', 'Corporate Event'],
            
            packages: [
                { Name: "Standard Light Drone Show", Price: 99000000, Desc: "Konfigurasi koreografi formasi 50 drone light show di udara selama 10 menit." },
                { Name: "Spectacular Premium Show", Price: 199000000, Desc: "Formasi masif 150 drone light show kustomisasi logo perusahaan / inisial pengantin." }
            ],
            
            services: [
                
                { name: 'Rundown and Scriptwriting', price: 0, required: true, desc: 'Sudah include manajemen rundown artis dan pengisi acara.' },
                { name: 'Master of Ceremony (MC)', price: 0, required: true, desc: 'Sudah include sepasang MC (Dual MC) untuk memandu acara besar.' },
                { name: 'Tim Dokumentasi dan Fotografi', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },
                { name: 'Guest Management', price: 0, required: true, desc: 'Sudah include tim ticketing, registrasi QR Code, dan penerima tamu.' },
                { name: 'Show Controlling', price: 0, required: true, desc: 'Sudah include komando penuh pertunjukan lampu (lighting) dan multimedia.' },

      
                { name: 'Live Painting', price: 7000000, required: false, desc: 'Melukis secara live suasana ground control station dan keindahan formasi drone.' },
                { name: 'Performer', price: 25000000, required: false, desc: 'Penyediaan musik latar orchestra / sound effect kustom sinkronisasi drone.' }
      ]    
    }
        
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
