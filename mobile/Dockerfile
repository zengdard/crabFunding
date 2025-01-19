FROM instrumentisto/flutter:latest

WORKDIR /app
COPY . .

# Configuration et build
RUN flutter config --no-analytics
RUN flutter doctor -v
RUN flutter create . --platforms=web
RUN flutter build web --release --web-renderer html
RUN flutter build apk --release

EXPOSE 8080
CMD ["flutter", "run", "--release", "--web-port", "8080", "--web-hostname", "0.0.0.0"]