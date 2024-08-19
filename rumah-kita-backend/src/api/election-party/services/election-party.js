'use strict';

/**
 * election-party service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::election-party.election-party');
