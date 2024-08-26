import type { Schema, Attribute } from '@strapi/strapi';

export interface AdminPermission extends Schema.CollectionType {
  collectionName: 'admin_permissions';
  info: {
    name: 'Permission';
    description: '';
    singularName: 'permission';
    pluralName: 'permissions';
    displayName: 'Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    actionParameters: Attribute.JSON & Attribute.DefaultTo<{}>;
    subject: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    properties: Attribute.JSON & Attribute.DefaultTo<{}>;
    conditions: Attribute.JSON & Attribute.DefaultTo<[]>;
    role: Attribute.Relation<'admin::permission', 'manyToOne', 'admin::role'>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminUser extends Schema.CollectionType {
  collectionName: 'admin_users';
  info: {
    name: 'User';
    description: '';
    singularName: 'user';
    pluralName: 'users';
    displayName: 'User';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    firstname: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastname: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    username: Attribute.String;
    email: Attribute.Email &
      Attribute.Required &
      Attribute.Private &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    password: Attribute.Password &
      Attribute.Private &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    resetPasswordToken: Attribute.String & Attribute.Private;
    registrationToken: Attribute.String & Attribute.Private;
    isActive: Attribute.Boolean &
      Attribute.Private &
      Attribute.DefaultTo<false>;
    roles: Attribute.Relation<'admin::user', 'manyToMany', 'admin::role'> &
      Attribute.Private;
    blocked: Attribute.Boolean & Attribute.Private & Attribute.DefaultTo<false>;
    preferedLanguage: Attribute.String;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'admin::user', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'admin::user', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface AdminRole extends Schema.CollectionType {
  collectionName: 'admin_roles';
  info: {
    name: 'Role';
    description: '';
    singularName: 'role';
    pluralName: 'roles';
    displayName: 'Role';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    code: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String;
    users: Attribute.Relation<'admin::role', 'manyToMany', 'admin::user'>;
    permissions: Attribute.Relation<
      'admin::role',
      'oneToMany',
      'admin::permission'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'admin::role', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'admin::role', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface AdminApiToken extends Schema.CollectionType {
  collectionName: 'strapi_api_tokens';
  info: {
    name: 'Api Token';
    singularName: 'api-token';
    pluralName: 'api-tokens';
    displayName: 'Api Token';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }> &
      Attribute.DefaultTo<''>;
    type: Attribute.Enumeration<['read-only', 'full-access', 'custom']> &
      Attribute.Required &
      Attribute.DefaultTo<'read-only'>;
    accessKey: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastUsedAt: Attribute.DateTime;
    permissions: Attribute.Relation<
      'admin::api-token',
      'oneToMany',
      'admin::api-token-permission'
    >;
    expiresAt: Attribute.DateTime;
    lifespan: Attribute.BigInteger;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::api-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::api-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminApiTokenPermission extends Schema.CollectionType {
  collectionName: 'strapi_api_token_permissions';
  info: {
    name: 'API Token Permission';
    description: '';
    singularName: 'api-token-permission';
    pluralName: 'api-token-permissions';
    displayName: 'API Token Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    token: Attribute.Relation<
      'admin::api-token-permission',
      'manyToOne',
      'admin::api-token'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::api-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::api-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminTransferToken extends Schema.CollectionType {
  collectionName: 'strapi_transfer_tokens';
  info: {
    name: 'Transfer Token';
    singularName: 'transfer-token';
    pluralName: 'transfer-tokens';
    displayName: 'Transfer Token';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }> &
      Attribute.DefaultTo<''>;
    accessKey: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastUsedAt: Attribute.DateTime;
    permissions: Attribute.Relation<
      'admin::transfer-token',
      'oneToMany',
      'admin::transfer-token-permission'
    >;
    expiresAt: Attribute.DateTime;
    lifespan: Attribute.BigInteger;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::transfer-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::transfer-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminTransferTokenPermission extends Schema.CollectionType {
  collectionName: 'strapi_transfer_token_permissions';
  info: {
    name: 'Transfer Token Permission';
    description: '';
    singularName: 'transfer-token-permission';
    pluralName: 'transfer-token-permissions';
    displayName: 'Transfer Token Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    token: Attribute.Relation<
      'admin::transfer-token-permission',
      'manyToOne',
      'admin::transfer-token'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::transfer-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::transfer-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUploadFile extends Schema.CollectionType {
  collectionName: 'files';
  info: {
    singularName: 'file';
    pluralName: 'files';
    displayName: 'File';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String & Attribute.Required;
    alternativeText: Attribute.String;
    caption: Attribute.String;
    width: Attribute.Integer;
    height: Attribute.Integer;
    formats: Attribute.JSON;
    hash: Attribute.String & Attribute.Required;
    ext: Attribute.String;
    mime: Attribute.String & Attribute.Required;
    size: Attribute.Decimal & Attribute.Required;
    url: Attribute.String & Attribute.Required;
    previewUrl: Attribute.String;
    provider: Attribute.String & Attribute.Required;
    provider_metadata: Attribute.JSON;
    related: Attribute.Relation<'plugin::upload.file', 'morphToMany'>;
    folder: Attribute.Relation<
      'plugin::upload.file',
      'manyToOne',
      'plugin::upload.folder'
    > &
      Attribute.Private;
    folderPath: Attribute.String &
      Attribute.Required &
      Attribute.Private &
      Attribute.SetMinMax<
        {
          min: 1;
        },
        number
      >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::upload.file',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::upload.file',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUploadFolder extends Schema.CollectionType {
  collectionName: 'upload_folders';
  info: {
    singularName: 'folder';
    pluralName: 'folders';
    displayName: 'Folder';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMax<
        {
          min: 1;
        },
        number
      >;
    pathId: Attribute.Integer & Attribute.Required & Attribute.Unique;
    parent: Attribute.Relation<
      'plugin::upload.folder',
      'manyToOne',
      'plugin::upload.folder'
    >;
    children: Attribute.Relation<
      'plugin::upload.folder',
      'oneToMany',
      'plugin::upload.folder'
    >;
    files: Attribute.Relation<
      'plugin::upload.folder',
      'oneToMany',
      'plugin::upload.file'
    >;
    path: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMax<
        {
          min: 1;
        },
        number
      >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::upload.folder',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::upload.folder',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginContentReleasesRelease extends Schema.CollectionType {
  collectionName: 'strapi_releases';
  info: {
    singularName: 'release';
    pluralName: 'releases';
    displayName: 'Release';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String & Attribute.Required;
    releasedAt: Attribute.DateTime;
    scheduledAt: Attribute.DateTime;
    timezone: Attribute.String;
    status: Attribute.Enumeration<
      ['ready', 'blocked', 'failed', 'done', 'empty']
    > &
      Attribute.Required;
    actions: Attribute.Relation<
      'plugin::content-releases.release',
      'oneToMany',
      'plugin::content-releases.release-action'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::content-releases.release',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::content-releases.release',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginContentReleasesReleaseAction
  extends Schema.CollectionType {
  collectionName: 'strapi_release_actions';
  info: {
    singularName: 'release-action';
    pluralName: 'release-actions';
    displayName: 'Release Action';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    type: Attribute.Enumeration<['publish', 'unpublish']> & Attribute.Required;
    entry: Attribute.Relation<
      'plugin::content-releases.release-action',
      'morphToOne'
    >;
    contentType: Attribute.String & Attribute.Required;
    locale: Attribute.String;
    release: Attribute.Relation<
      'plugin::content-releases.release-action',
      'manyToOne',
      'plugin::content-releases.release'
    >;
    isEntryValid: Attribute.Boolean;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::content-releases.release-action',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::content-releases.release-action',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsPermission
  extends Schema.CollectionType {
  collectionName: 'up_permissions';
  info: {
    name: 'permission';
    description: '';
    singularName: 'permission';
    pluralName: 'permissions';
    displayName: 'Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String & Attribute.Required;
    role: Attribute.Relation<
      'plugin::users-permissions.permission',
      'manyToOne',
      'plugin::users-permissions.role'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsRole extends Schema.CollectionType {
  collectionName: 'up_roles';
  info: {
    name: 'role';
    description: '';
    singularName: 'role';
    pluralName: 'roles';
    displayName: 'Role';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 3;
      }>;
    description: Attribute.String;
    type: Attribute.String & Attribute.Unique;
    permissions: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToMany',
      'plugin::users-permissions.permission'
    >;
    users: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToMany',
      'plugin::users-permissions.user'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsUser extends Schema.CollectionType {
  collectionName: 'up_users';
  info: {
    name: 'user';
    description: '';
    singularName: 'user';
    pluralName: 'users';
    displayName: 'User';
  };
  options: {
    draftAndPublish: false;
    timestamps: true;
  };
  attributes: {
    username: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 3;
      }>;
    email: Attribute.Email &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    provider: Attribute.String;
    password: Attribute.Password &
      Attribute.Private &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    resetPasswordToken: Attribute.String & Attribute.Private;
    confirmationToken: Attribute.String & Attribute.Private;
    confirmed: Attribute.Boolean & Attribute.DefaultTo<false>;
    blocked: Attribute.Boolean & Attribute.DefaultTo<false>;
    role: Attribute.Relation<
      'plugin::users-permissions.user',
      'manyToOne',
      'plugin::users-permissions.role'
    >;
    user_detail: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'api::user-detail.user-detail'
    >;
    surat_pengajuans: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::surat-pengajuan.surat-pengajuan'
    >;
    aduans: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::aduan.aduan'
    >;
    kegiatans: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::kegiatan.kegiatan'
    >;
    election_registrations: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::election-registration.election-registration'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginI18NLocale extends Schema.CollectionType {
  collectionName: 'i18n_locale';
  info: {
    singularName: 'locale';
    pluralName: 'locales';
    collectionName: 'locales';
    displayName: 'Locale';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.SetMinMax<
        {
          min: 1;
          max: 50;
        },
        number
      >;
    code: Attribute.String & Attribute.Unique;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::i18n.locale',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::i18n.locale',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiAduanAduan extends Schema.CollectionType {
  collectionName: 'aduans';
  info: {
    singularName: 'aduan';
    pluralName: 'aduans';
    displayName: 'Aduan';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    title: Attribute.String & Attribute.Required;
    description: Attribute.Text & Attribute.Required;
    location: Attribute.String & Attribute.Required;
    date_of_incident: Attribute.DateTime & Attribute.Required;
    reject_description: Attribute.Text;
    attachment: Attribute.Media<'images' | 'files' | 'videos' | 'audios'>;
    users_permissions_user: Attribute.Relation<
      'api::aduan.aduan',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    document_status: Attribute.Relation<
      'api::aduan.aduan',
      'manyToOne',
      'api::document-status.document-status'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::aduan.aduan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::aduan.aduan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiDocumentStatusDocumentStatus extends Schema.CollectionType {
  collectionName: 'document_statuses';
  info: {
    singularName: 'document-status';
    pluralName: 'document-statuses';
    displayName: 'Document Status';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    status: Attribute.String & Attribute.Required & Attribute.Unique;
    label: Attribute.String & Attribute.Required;
    description: Attribute.Text;
    surat_pengajuans: Attribute.Relation<
      'api::document-status.document-status',
      'oneToMany',
      'api::surat-pengajuan.surat-pengajuan'
    >;
    aduans: Attribute.Relation<
      'api::document-status.document-status',
      'oneToMany',
      'api::aduan.aduan'
    >;
    kegiatans: Attribute.Relation<
      'api::document-status.document-status',
      'oneToMany',
      'api::kegiatan.kegiatan'
    >;
    election_registrations: Attribute.Relation<
      'api::document-status.document-status',
      'oneToMany',
      'api::election-registration.election-registration'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::document-status.document-status',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::document-status.document-status',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiElectionElection extends Schema.CollectionType {
  collectionName: 'elections';
  info: {
    singularName: 'election';
    pluralName: 'elections';
    displayName: 'Election';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    kegiatan: Attribute.Relation<
      'api::election.election',
      'oneToOne',
      'api::kegiatan.kegiatan'
    >;
    election_parties: Attribute.Relation<
      'api::election.election',
      'oneToMany',
      'api::election-party.election-party'
    >;
    election_registrations: Attribute.Relation<
      'api::election.election',
      'oneToMany',
      'api::election-registration.election-registration'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::election.election',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::election.election',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiElectionPartyElectionParty extends Schema.CollectionType {
  collectionName: 'election_parties';
  info: {
    singularName: 'election-party';
    pluralName: 'election-parties';
    displayName: 'Election Party';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    no_urut: Attribute.Integer &
      Attribute.Required &
      Attribute.SetMinMax<
        {
          min: 0;
        },
        number
      >;
    ketua: Attribute.String & Attribute.Required;
    photo_ketua: Attribute.Media<'images'>;
    wakil_ketua: Attribute.String & Attribute.Required;
    photo_wakil_ketua: Attribute.Media<'images'>;
    election: Attribute.Relation<
      'api::election-party.election-party',
      'manyToOne',
      'api::election.election'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::election-party.election-party',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::election-party.election-party',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiElectionRegistrationElectionRegistration
  extends Schema.CollectionType {
  collectionName: 'election_registrations';
  info: {
    singularName: 'election-registration';
    pluralName: 'election-registrations';
    displayName: 'Election Registration';
    description: '';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    reject_description: Attribute.Text;
    attachment: Attribute.Media<'files'>;
    users_permissions_user: Attribute.Relation<
      'api::election-registration.election-registration',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    election: Attribute.Relation<
      'api::election-registration.election-registration',
      'manyToOne',
      'api::election.election'
    >;
    document_status: Attribute.Relation<
      'api::election-registration.election-registration',
      'manyToOne',
      'api::document-status.document-status'
    >;
    election_voters: Attribute.Relation<
      'api::election-registration.election-registration',
      'oneToMany',
      'api::election-voter.election-voter'
    >;
    kegiatan: Attribute.Relation<
      'api::election-registration.election-registration',
      'manyToOne',
      'api::kegiatan.kegiatan'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::election-registration.election-registration',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::election-registration.election-registration',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiElectionVoterElectionVoter extends Schema.CollectionType {
  collectionName: 'election_voters';
  info: {
    singularName: 'election-voter';
    pluralName: 'election-voters';
    displayName: 'Election Voter';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    name: Attribute.String & Attribute.Required;
    election_registration: Attribute.Relation<
      'api::election-voter.election-voter',
      'manyToOne',
      'api::election-registration.election-registration'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::election-voter.election-voter',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::election-voter.election-voter',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiJenisSuratPengajuanJenisSuratPengajuan
  extends Schema.CollectionType {
  collectionName: 'jenis_surat_pengajuans';
  info: {
    singularName: 'jenis-surat-pengajuan';
    pluralName: 'jenis-surat-pengajuans';
    displayName: 'Jenis Surat Pengajuan';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    jenis: Attribute.String & Attribute.Required & Attribute.Unique;
    label: Attribute.String & Attribute.Required;
    description: Attribute.Text;
    surat_pengajuans: Attribute.Relation<
      'api::jenis-surat-pengajuan.jenis-surat-pengajuan',
      'oneToMany',
      'api::surat-pengajuan.surat-pengajuan'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::jenis-surat-pengajuan.jenis-surat-pengajuan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::jenis-surat-pengajuan.jenis-surat-pengajuan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiKategoriKegiatanKategoriKegiatan
  extends Schema.CollectionType {
  collectionName: 'kategori_kegiatans';
  info: {
    singularName: 'kategori-kegiatan';
    pluralName: 'kategori-kegiatans';
    displayName: 'Kategori Kegiatan';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    kategori: Attribute.String & Attribute.Required & Attribute.Unique;
    label: Attribute.String & Attribute.Required;
    description: Attribute.Text;
    cover: Attribute.Media<'images'>;
    kegiatans: Attribute.Relation<
      'api::kategori-kegiatan.kategori-kegiatan',
      'oneToMany',
      'api::kegiatan.kegiatan'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::kategori-kegiatan.kategori-kegiatan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::kategori-kegiatan.kategori-kegiatan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiKegiatanKegiatan extends Schema.CollectionType {
  collectionName: 'kegiatans';
  info: {
    singularName: 'kegiatan';
    pluralName: 'kegiatans';
    displayName: 'Kegiatan';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    title: Attribute.String & Attribute.Required;
    description: Attribute.Text & Attribute.Required;
    start_date: Attribute.DateTime & Attribute.Required;
    finish_date: Attribute.DateTime & Attribute.Required;
    reject_description: Attribute.Text;
    attachment: Attribute.Media<'images' | 'files'>;
    users_permissions_user: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    kategori_kegiatan: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'manyToOne',
      'api::kategori-kegiatan.kategori-kegiatan'
    >;
    document_status: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'manyToOne',
      'api::document-status.document-status'
    >;
    kerja_bakti: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'oneToOne',
      'api::kerja-bakti.kerja-bakti'
    >;
    election: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'oneToOne',
      'api::election.election'
    >;
    election_registrations: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'oneToMany',
      'api::election-registration.election-registration'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::kegiatan.kegiatan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiKerjaBaktiKerjaBakti extends Schema.CollectionType {
  collectionName: 'kerja_baktis';
  info: {
    singularName: 'kerja-bakti';
    pluralName: 'kerja-baktis';
    displayName: 'Kerja Bakti';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    description: Attribute.Text & Attribute.Required;
    photos: Attribute.Media<'images', true>;
    kegiatan: Attribute.Relation<
      'api::kerja-bakti.kerja-bakti',
      'oneToOne',
      'api::kegiatan.kegiatan'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::kerja-bakti.kerja-bakti',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::kerja-bakti.kerja-bakti',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiSuratPengajuanSuratPengajuan extends Schema.CollectionType {
  collectionName: 'surat_pengajuans';
  info: {
    singularName: 'surat-pengajuan';
    pluralName: 'surat-pengajuans';
    displayName: 'Surat Pengajuan';
    description: '';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    fullname: Attribute.String & Attribute.Required;
    email: Attribute.String & Attribute.Required;
    alamat: Attribute.Text & Attribute.Required;
    reject_description: Attribute.Text;
    documents: Attribute.Media<'images' | 'files', true>;
    users_permissions_user: Attribute.Relation<
      'api::surat-pengajuan.surat-pengajuan',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    document_status: Attribute.Relation<
      'api::surat-pengajuan.surat-pengajuan',
      'manyToOne',
      'api::document-status.document-status'
    >;
    jenis_surat_pengajuan: Attribute.Relation<
      'api::surat-pengajuan.surat-pengajuan',
      'manyToOne',
      'api::jenis-surat-pengajuan.jenis-surat-pengajuan'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::surat-pengajuan.surat-pengajuan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::surat-pengajuan.surat-pengajuan',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiUserDetailUserDetail extends Schema.CollectionType {
  collectionName: 'user_details';
  info: {
    singularName: 'user-detail';
    pluralName: 'user-details';
    displayName: 'User Detail';
    description: '';
  };
  options: {
    draftAndPublish: true;
  };
  attributes: {
    fullname: Attribute.String & Attribute.Required;
    jenis_kelamin: Attribute.String & Attribute.Required;
    rw: Attribute.String & Attribute.Required;
    rt: Attribute.String & Attribute.Required;
    alamat: Attribute.Text & Attribute.Required;
    domisili: Attribute.Text & Attribute.Required;
    users_permissions_user: Attribute.Relation<
      'api::user-detail.user-detail',
      'oneToOne',
      'plugin::users-permissions.user'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    publishedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::user-detail.user-detail',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::user-detail.user-detail',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface ContentTypes {
      'admin::permission': AdminPermission;
      'admin::user': AdminUser;
      'admin::role': AdminRole;
      'admin::api-token': AdminApiToken;
      'admin::api-token-permission': AdminApiTokenPermission;
      'admin::transfer-token': AdminTransferToken;
      'admin::transfer-token-permission': AdminTransferTokenPermission;
      'plugin::upload.file': PluginUploadFile;
      'plugin::upload.folder': PluginUploadFolder;
      'plugin::content-releases.release': PluginContentReleasesRelease;
      'plugin::content-releases.release-action': PluginContentReleasesReleaseAction;
      'plugin::users-permissions.permission': PluginUsersPermissionsPermission;
      'plugin::users-permissions.role': PluginUsersPermissionsRole;
      'plugin::users-permissions.user': PluginUsersPermissionsUser;
      'plugin::i18n.locale': PluginI18NLocale;
      'api::aduan.aduan': ApiAduanAduan;
      'api::document-status.document-status': ApiDocumentStatusDocumentStatus;
      'api::election.election': ApiElectionElection;
      'api::election-party.election-party': ApiElectionPartyElectionParty;
      'api::election-registration.election-registration': ApiElectionRegistrationElectionRegistration;
      'api::election-voter.election-voter': ApiElectionVoterElectionVoter;
      'api::jenis-surat-pengajuan.jenis-surat-pengajuan': ApiJenisSuratPengajuanJenisSuratPengajuan;
      'api::kategori-kegiatan.kategori-kegiatan': ApiKategoriKegiatanKategoriKegiatan;
      'api::kegiatan.kegiatan': ApiKegiatanKegiatan;
      'api::kerja-bakti.kerja-bakti': ApiKerjaBaktiKerjaBakti;
      'api::surat-pengajuan.surat-pengajuan': ApiSuratPengajuanSuratPengajuan;
      'api::user-detail.user-detail': ApiUserDetailUserDetail;
    }
  }
}
