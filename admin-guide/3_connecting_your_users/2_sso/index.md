---
slug: single-sign-on-features
title: Single-Sign-On Features
description: Exploring the features of Pydio Cells to address authentication related problematics in your organisation larger infrastructure.
menu: Single-Sign-On Features
language: und
weight: 2
menu_name: menu-admin-guide-v7-enterprise

---
## Single Sign On (SSO)

### What is it?

Single Sign-On is a service that allows a user to use one login session to access multiple applications.

### What does it mean in Pydio Cells?

Pydio Cells can be used as an [Identity Provider](./cells-identity-provider). In other words, any application can use the login session from Pydio Cells to validate access to a user and use its data.

### What does it mean in Pydio Cells Enterprise Distribution?

On top of that, Cells Ent can integrate with multiple [External Identity Providers](./ed-using-sso-external-identity-provider). It automatically creates access for users from third-party services (commercial or on-premise) and understands multiple protocols (*OIDC*, *SAML2.0*, ...).

Furthermore, Cells Ent provides a simple way to connect one or many external [LDAP or Active Directory](./ed-binding-ldap) servers.

- [Cells as Identity Provider](/cells-v4/admin-guide/connect-your-users/single-sign-on-features/cells-as-identity-provider/)
- [[Ent] Using SSO with an External Identity Provider](/cells-v4/admin-guide/connect-your-users/single-sign-on-features/ent-using-sso-with-an-external-identity-provider/)
- [[Ent] LDAP / AD](/cells-v4/admin-guide/connect-your-users/single-sign-on-features/ent-ldap-ad/)
- [[Ent] LDAP / AD (Advanced)](/cells-v4/admin-guide/connect-your-users/single-sign-on-features/ent-ldap-ad-advanced/)
- [[Ent] AD + Kerberos Support](/cells-v4/admin-guide/connect-your-users/single-sign-on-features/ent-ad-kerberos-support/)

--------------------------------------------------------------------------------------------------------
_See Also_

- [OpenID Connect](https://openid.net/connect/)
- [OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749)
