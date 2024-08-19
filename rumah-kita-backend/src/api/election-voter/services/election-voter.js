'use strict';

/**
 * election-voter service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::election-voter.election-voter');
