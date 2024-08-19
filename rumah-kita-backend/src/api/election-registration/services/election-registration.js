'use strict';

/**
 * election-registration service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::election-registration.election-registration');
