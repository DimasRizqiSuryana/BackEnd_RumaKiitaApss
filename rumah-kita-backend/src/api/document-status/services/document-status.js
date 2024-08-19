'use strict';

/**
 * document-status service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::document-status.document-status');
