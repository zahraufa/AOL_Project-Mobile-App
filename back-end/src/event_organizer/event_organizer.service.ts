import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class EventOrganizerService {
    [x: string]: any;
    private _prismaservice: PrismaService;

    constructor(prismaservice: PrismaService) {
        this._prismaservice = prismaservice;
    }   

    async getAllEO(){
        const allEO = await this._prismaservice.event_organizer.findMany({
            include: {
                eo_package: true,
                event_organizer_categories:{
                    include: {
                        eo_category: true
                    }
                }
            }
        })
        return allEO.map((eo) => ({
            EO_ID: eo.EO_ID,
            EO_name: eo.EO_name,
            EO_Rating: eo.EO_Rating,
            EO_Image: eo.EO_Image,

            lowet_price: eo.eo_package.length > 0 ? Math.min(...eo.eo_package.map((pkg) => Number(pkg.Package_Price))) : null,

            categories: eo.event_organizer_categories.map((categ)=> categ.eo_category.Category_Name),
    }))
    }

    async getEOByID(EO_ID: number){
        const eventOrganizer = await this._prismaservice.event_organizer.findUnique({
            where: {
                EO_ID: EO_ID
            },
            include: {
                eo_package: true,
                event_organizer_categories: {
                    include: {
                        eo_category: true
                    },
                },

                event_organizer_services: {
                    include: {
                        services: true
                    },
                },

                rating: true,
            }
        });
        if (!eventOrganizer) {
            throw new Error(`Event Organizer dengan ID ${EO_ID} tidak ditemukan`);
        }
        return {
             message: 'Success get Event Organizer detail',
      data: {
        EO_ID: eventOrganizer.EO_ID,
        EO_name: eventOrganizer.EO_name,
        EO_Description:
          eventOrganizer.EO_Description,
        EO_Address:
          eventOrganizer.EO_Address,
        EO_Number:
          eventOrganizer.EO_Number,
        EO_Rating:
          eventOrganizer.EO_Rating,
        EO_Image:
          eventOrganizer.EO_Image,

        categories:
          eventOrganizer.event_organizer_categories.map((category) => ({
              Category_ID:
                category.eo_category.Category_ID,

              Category_Name:
                category.eo_category
                  .Category_Name,
            })),

        packages:
          eventOrganizer.eo_package.map((pkg) => ({
              Package_ID:
                pkg.Package_ID,

              Package_Name:
                pkg.Package_Name,

              Package_Price:
                pkg.Package_Price,

              Package_Description:
                pkg.Package_Description,

              Package_Image:
                pkg.Package_Image,
            })),

        included_services:
          eventOrganizer.event_organizer_services.filter((service) => service.Is_Required === true).map((service) => ({
              EO_services_ID:
                service.EO_services_ID,

              Service_Name:
                service.services
                  .Service_name,

              Description:
                service.Service_Description,
            })),

        add_ons:
          eventOrganizer.event_organizer_services.filter((service) => service.Is_Required === false).map((service) => ({
              EO_services_ID:
                service.EO_services_ID,

              Service_Name:
                service.services
                  .Service_name,

              Price:
                service.Service_Price,

              Description:
                service.Service_Description,
            })),

        total_rating:
          eventOrganizer.rating.length,
        }
    }
}

    async compareEOs(id: string){
        if (!id) {
        throw new BadRequestException('Please provide EO ids');
        }

        const eoId = id.split(',').map((id) => Number(id.trim()));
        if(eoId.length < 2){
            throw new BadRequestException('Please provide at least 2 EO ids for comparison');
        }

        const eventOrganizers = await this._prismaservice.event_organizer.findMany({
            where: {
                EO_ID: {
                    in: eoId
                }
            },

            include: {
                eo_package: true,
                event_organizer_categories: {
                    include: {
                        eo_category: true   
                    } 
                },

                event_organizer_services: {
                    include: {
                        services: true
                    }
                },
            }
        });

        return {
            message: 'Success comparing EOs',
            data: eventOrganizers.map((eo) => ({
                EO_ID: eo.EO_ID,
                EO_name: eo.EO_name,
                EO_Rating: eo.EO_Rating,
                EO_Image: eo.EO_Image,

                categories: eo.event_organizer_categories.map((categ) => categ.eo_category.Category_Name),
                packages: eo.eo_package.map((pkg) => ({
                    Package_ID: pkg.Package_ID,
                    Package_Name: pkg.Package_Name,
                    Package_Price: pkg.Package_Price,
                    Package_Description: pkg.Package_Description
            })),

                included_services: eo.event_organizer_services.filter((service) => service.Is_Required === true).map((service) => ({
                    EO_services_ID: service.EO_services_ID,
                    Service_Name: service.services.Service_name,
                    Description: service.Service_Description
                })),

                add_ons: eo.event_organizer_services.filter((service) => service.Is_Required === false).map((service) => ({
                    EO_services_ID: service.EO_services_ID,
                    Service_Name: service.services.Service_name,
                    Price: service.Service_Price,
                    Description: service.Service_Description
                })),
            }))
        }
    }
}