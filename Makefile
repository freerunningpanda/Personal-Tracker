force-get: remove-pubspec-lock get

get:
	@echo "*️⃣ tracker get packages"
	@flutter clean && flutter pub get

gen:
	@echo "*️⃣ Codegen started ..."
	@dart run build_runner build --delete-conflicting-outputs