import { Module } from '@nestjs/common';
import { CompareFeaturesController } from './compare_features.controller';

@Module({
  controllers: [CompareFeaturesController]
})
export class CompareFeaturesModule {}
