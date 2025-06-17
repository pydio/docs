---
title: Single-Sign-On Features
weight: 0
---
## Single Sign On (SSO)

### What is it?

Single Sign-On is a service that allows a user to use one login session to access multiple applications.

### What does it mean in Pydio Cells?

Pydio Cells can be used as an [Identity Provider](../cells-identity-provider). In other words, any application can use the login session from Pydio Cells to validate access to a user and use its data.

### What does it mean in Pydio Cells Enterprise Distribution?

On top of that, Cells Ent can integrate with multiple [External Identity Providers](./ed-using-sso-external-identity-provider). It automatically creates access for users from third-party services (commercial or on-premise) and understands multiple protocols (*OIDC*, *SAML2.0*, ...).

Furthermore, Cells Ent provides a simple way to connect one or many external [LDAP or Active Directory](./ed-binding-ldap) servers.

* [Cells as Identity Provider](../cells-as-identity-provider/)
* [[Ent] Using SSO with an External Identity Provider](../ent-using-sso-with-an-external-identity-provider/)
* [[Ent] LDAP / AD](../ent-ldap-ad/)
* [[Ent] LDAP / AD (Advanced)](../ent-ldap-ad-advanced/)
* [[Ent] AD + Kerberos Support](../ent-ad-kerberos-support/)

--------------------------------------------------------------------------------------------------------
_See Also_

- [OpenID Connect](https://openid.net/connect/)
- [OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749)
