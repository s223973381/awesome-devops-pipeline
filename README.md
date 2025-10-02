# Awesome DevOps Pipeline 🚀

This project demonstrates **End-to-End Automated CI/CD** with:
- CI (build, test, push to ACR)
- Staging 1 & 2 (provision, deploy, smoke test, teardown)
- Production (manual approval + deploy)

## Features
✅ Automated builds on `testing` branch  
✅ Staging environment deployed & destroyed on demand  
✅ Production environment deployed manually  
✅ Terraform for Azure provisioning 

## Workflows
- `.github/workflows/ci.yml`
- `.github/workflows/deploy-staging.yml`
- `.github/workflows/deploy-prod.yml`

## How to Run
1. Push code to `testing` branch → CI builds & pushes image.  
2. CI success → triggers staging workflow → deploys & destroys staging.  
3. Manual trigger → deploys to production.  
