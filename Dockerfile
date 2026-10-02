FROM nginx:alpine

# Security Metadata
LABEL maintainer="spec-kit"
LABEL version="2.0.0"
LABEL description="Spec Kit - Hardened Documentation & Tooling Server"
LABEL security.hardened="true"

# Copy documentation and web assets with unprivileged ownership
COPY --chown=nginx:nginx . /usr/share/nginx/html

# Enforce secure read/execute permissions
RUN chmod -R 755 /usr/share/nginx/html

# Health check to ensure web server availability
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]