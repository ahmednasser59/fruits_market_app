# 📋 Fruits Hub — Features & Code Reference

This document provides a detailed breakdown of every feature in the app along with file references for each component.

---

## 1. Splash Screen

The app entry point that checks user state and routes accordingly.

| Layer | File |
|-------|------|
| View | `lib/features/splash/presentation/views/splash_view.dart` |

**Behavior**: Displays the app logo, then navigates to onboarding (first launch), sign-in (unauthenticated), or home (authenticated).

---

## 2. Onboarding

A page-view introduction shown to first-time users.

| Layer | File |
|-------|------|
| View | `lib/features/on_boarding/presentation/views/on_boarding_view.dart` |
| Body Widget | `lib/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart` |

**Key Details**:
- Uses `dots_indicator` for page navigation
- Persists "seen" state via SharedPreferences key `isOnBoardingViewSeen`
- SVG background illustrations (`page_view_item1_background_image.svg`, etc.)

---

## 3. Authentication

Full authentication system supporting multiple sign-in providers.

### 3.1 Domain Layer

| Component | File |
|-----------|------|
| User Entity | `lib/features/auth/domain/entites/user_entity.dart` |
| Auth Repo (interface) | `lib/features/auth/domain/repos/auth_repo.dart` |

**User Entity fields**: `name`, `email`, `uId`

**Auth Repo methods**:
- `createUserWithEmailAndPassword(email, password, name)`
- `signinWithEmailAndPassword(email, password)`
- `signinWithGoogle()`
- `signinWithFacebook()`
- `signinWithApple()`
- `addUserData(user)` / `saveUserData(user)` / `getUserData(uid)`

### 3.2 Data Layer

| Component | File |
|-----------|------|
| User Model | `lib/features/auth/data/models/user_model.dart` |
| Auth Repo Implementation | `lib/features/auth/data/repos/auth_repo_impl.dart` |

### 3.3 Presentation Layer

| Component | File |
|-----------|------|
| Sign In View | `lib/features/auth/presentation/views/signin_view.dart` |
| Sign Up View | `lib/features/auth/presentation/views/signup_view.dart` |
| Sign In Cubit | `lib/features/auth/presentation/cubits/signin_cubit/` |
| Sign Up Cubit | `lib/features/auth/presentation/cubits/signup_cubits/` |
| Widgets | `lib/features/auth/presentation/views/widgets/` |

### 3.4 Services

| Service | File |
|---------|------|
| Firebase Auth Service | `lib/core/services/firebase_auth_service.dart` |

---

## 4. Home / Main View

The primary app screen with bottom navigation.

| Component | File |
|-----------|------|
| Main View | `lib/features/home/presentation/views/main_view.dart` |
| Home View | `lib/features/home/presentation/views/widgets/home_view.dart` |
| Home View Body | `lib/features/home/presentation/views/widgets/home_view_body.dart` |
| Custom Bottom Nav | `lib/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart` |
| Main View Body | `lib/features/home/presentation/views/widgets/main_view_body.dart` |
| BLoC Consumer | `lib/features/home/presentation/views/widgets/main_view_body_bloc_consumer.dart` |

**Navigation Tabs** (via `CustomBottomNavigationBar`):
- Home (products)
- Cart
- Products (grid view)

**Bottom Nav Entities**: `lib/features/home/domain/entites/bottom_navigation_bar_entity.dart`

---

## 5. Products

Product listing with featured items and best sellers.

### 5.1 Domain / Core Entities

| Component | File |
|-----------|------|
| Product Entity | `lib/core/entities/product_entity.dart` |
| Review Entity | `lib/core/entities/review_entity.dart` |

**Product Entity fields**:
- `name`, `code`, `description`, `price`
- `isFeatured`, `imageUrl`, `expirationsMonths`
- `isOrganic`, `numberOfCalories`, `unitAmount`
- `reviews` (list of ReviewEntity)
- `avgRating`, `ratingCount`

**Review Entity fields**: `name`, `image`, `ratting`, `date`, `reviewDescription`

### 5.2 Data Layer

| Component | File |
|-----------|------|
| Product Model | `lib/core/models/product_model.dart` |
| Review Model | `lib/core/models/review_model.dart` |
| Products Repo Implementation | `lib/core/repos/products_repo/products_repo_impl.dart` |

### 5.3 Repository Interface

| Component | File |
|-----------|------|
| Products Repo | `lib/core/repos/products_repo/products_repo.dart` |

**Methods**:
- `getProducts()` → `List<ProductEntity>`
- `getBestSellingProducts()` → `List<ProductEntity>`

### 5.4 State Management

| Component | File |
|-----------|------|
| Products Cubit | `lib/core/cubits/products_cubit/products_cubit.dart` |
| Products State | `lib/core/cubits/products_cubit/products_state.dart` |

### 5.5 Presentation Widgets

| Widget | File |
|--------|------|
| Products Grid View | `lib/features/home/presentation/views/widgets/products_grid_view.dart` |
| Products Grid BlocBuilder | `lib/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart` |
| Featured Item | `lib/features/home/presentation/views/widgets/featured_item.dart` |
| Featured List | `lib/features/home/presentation/views/widgets/featured_list.dart` |
| Featured Item Button | `lib/features/home/presentation/views/widgets/featured_item_button.dart` |
| Best Selling Header | `lib/features/home/presentation/views/widgets/best_selling_header.dart` |
| Products View Body | `lib/features/home/presentation/views/widgets/products_view_body.dart` |
| Products View Header | `lib/features/home/presentation/views/widgets/products_view_header.dart` |
| Fruit Item (shared) | `lib/core/widgets/fruit_item.dart` |

---

## 6. Best Selling Fruits

Dedicated view for best-selling products.

| Component | File |
|-----------|------|
| Best Selling View | `lib/features/best_selling_fruits/presentation/views/best_selling_view.dart` |

---

## 7. Shopping Cart

Full cart management with quantity controls and total price calculation.

### 7.1 Domain Entities

| Entity | File |
|--------|------|
| Cart Entity | `lib/features/home/domain/entites/cart_entity.dart` |
| Cart Item Entity | `lib/features/home/domain/entites/car_item_entity.dart` |

**Cart Entity methods**:
- `addCartItem(item)` / `removeCarItem(item)`
- `calculateTotalPrice()`
- `isExis(product)` — check if product exists in cart
- `getCarItem(product)` — get existing cart item

**Cart Item Entity**:
- Fields: `productEntity`, `quanitty`
- Methods: `calculateTotalPrice()`, `calculateTotalWeight()`, `increasQuantity()`, `decreasQuantity()`

### 7.2 State Management

| Component | File |
|-----------|------|
| Cart Cubit | `lib/features/home/presentation/cubits/cart_cubit/` |
| Cart Item Cubit | `lib/features/home/presentation/cubits/cart_item_cubit/` |

### 7.3 Presentation

| Widget | File |
|--------|------|
| Cart View | `lib/features/home/presentation/views/cart_view.dart` |
| Cart View Body | `lib/features/home/presentation/views/widgets/cart_view_body.dart` |
| Cart Items List | `lib/features/home/presentation/views/widgets/car_items_list.dart` |
| Cart Item Widget | `lib/features/home/presentation/views/widgets/cart_item.dart` |
| Cart Item Actions | `lib/features/home/presentation/views/widgets/cart_item_action_buttons.dart` |
| Cart Header | `lib/features/home/presentation/views/widgets/cart_header.dart` |
| Custom Cart Button | `lib/features/home/presentation/views/widgets/custom_cart_button.dart` |

---

## 8. Checkout

Multi-step checkout process: Shipping → Payment → Order Summary.

### 8.1 Domain Entities

| Entity | File |
|--------|------|
| Order Input Entity | `lib/features/checkout/domain/entites/order_entity.dart` |
| Shipping Address Entity | `lib/features/checkout/domain/entites/shipping_address_entity.dart` |
| PayPal Payment Entity | `lib/features/checkout/domain/entites/paypal_payment_entity/paypal_payment_entity.dart` |
| PayPal Amount | `lib/features/checkout/domain/entites/paypal_payment_entity/amount.dart` |
| PayPal Details | `lib/features/checkout/domain/entites/paypal_payment_entity/details.dart` |
| PayPal Item | `lib/features/checkout/domain/entites/paypal_payment_entity/item.dart` |
| PayPal Item List | `lib/features/checkout/domain/entites/paypal_payment_entity/item_list.dart` |

**Order Entity fields**: `uID`, `cartEntity`, `payWithCash`, `shippingAddressEntity`
**Order methods**: `calculateShippingCost()`, `calcualteShippingDiscount()`, `calculateTotalPriceAfterDiscountAndShipping()`

**Shipping Address fields**: `name`, `phone`, `address`, `city`, `email`, `floor`

### 8.2 Data Layer

| Component | File |
|-----------|------|
| Order Model | `lib/features/checkout/data/models/order_model.dart` |
| Order Product Model | `lib/features/checkout/data/models/order_product_model.dart` |
| Shipping Address Model | `lib/features/checkout/data/models/shipping_address_model.dart` |
| Orders Repo | `lib/core/repos/orders_repo/orders_repo.dart` |
| Orders Repo Implementation | `lib/core/repos/orders_repo/orders_repo_impl.dart` |

**Orders Repo method**: `addOrder(order)` → saves order to Firestore

### 8.3 State Management

| Component | File |
|-----------|------|
| Add Order Cubit | `lib/features/checkout/presentation/manger/add_order_cubit/` |

### 8.4 Presentation

| Widget | File |
|--------|------|
| Checkout View | `lib/features/checkout/presentation/views/checkout_view.dart` |
| Checkout View Body | `lib/features/checkout/presentation/views/widgets/checkout_view_body.dart` |
| Checkout Steps | `lib/features/checkout/presentation/views/widgets/checkout_steps.dart` |
| Steps Page View | `lib/features/checkout/presentation/views/widgets/checkout_steps_page_view.dart` |
| Step Item | `lib/features/checkout/presentation/views/widgets/step_item.dart` |
| Active Step | `lib/features/checkout/presentation/views/widgets/active_step_item.dart` |
| Inactive Step | `lib/features/checkout/presentation/views/widgets/in_active_step_item.dart` |
| Shipping Section | `lib/features/checkout/presentation/views/widgets/shipping_section.dart` |
| Shipping Item | `lib/features/checkout/presentation/views/widgets/shipping_item.dart` |
| Shipping Address Widget | `lib/features/checkout/presentation/views/widgets/shipping_address_widget.dart` |
| Address Input Section | `lib/features/checkout/presentation/views/widgets/address_input_section.dart` |
| Payment Section | `lib/features/checkout/presentation/views/widgets/payment_section.dart` |
| Payment Item | `lib/features/checkout/presentation/views/widgets/payment_item.dart` |
| Order Summary | `lib/features/checkout/presentation/views/widgets/order_summry_widget.dart` |
| Add Order BlocBuilder | `lib/features/checkout/presentation/views/widgets/add_order_cubit_bloc_builder.dart` |

---

## 9. Core Services

### 9.1 Firebase

| Service | File |
|---------|------|
| Firebase Auth Service | `lib/core/services/firebase_auth_service.dart` |
| Firestore Service | `lib/core/services/firestore_service.dart` |
| Database Service (interface) | `lib/core/services/data_service.dart` |

**Database Service methods**:
- `addData(path, data, documentId?)`
- `getData(path, docuementId?, query?)`
- `checkIfDataExists(path, docuementId)`

**Firestore Collections** (from `BackendEndpoint`):
- `users` — user profiles
- `products` — fruit products
- `Orders` — completed orders

### 9.2 Dependency Injection

| File | Description |
|------|-------------|
| `lib/core/services/get_it_service.dart` | GetIt setup — registers Auth, Products, Orders repos |

### 9.3 Local Storage

| File | Description |
|------|-------------|
| `lib/core/services/shared_preferences_singleton.dart` | SharedPreferences singleton wrapper |

### 9.4 BLoC Observer

| File | Description |
|------|-------------|
| `lib/core/services/custom_bloc_observer.dart` | Custom observer for debugging state changes |

---

## 10. Core Utilities

| Utility | File |
|---------|------|
| App Colors | `lib/core/utils/app_colors.dart` |
| App Text Styles | `lib/core/utils/app_text_styles.dart` |
| App Images | `lib/core/utils/app_images.dart` |
| App Decorations | `lib/core/utils/app_decorations.dart` |
| App Keys | `lib/core/utils/app_keys.dart` |
| Backend Endpoints | `lib/core/utils/backend_endpoint.dart` |

---

## 11. Core Reusable Widgets

| Widget | File |
|--------|------|
| Build App Bar | `lib/core/widgets/build_app_bar.dart` |
| Custom App Bar | `lib/core/widgets/custom_app_bar.dart` |
| Custom Button | `lib/core/widgets/custom_button.dart` |
| Custom Error Widget | `lib/core/widgets/custom_error_widget.dart` |
| Custom Network Image | `lib/core/widgets/custom_network_image.dart` |
| Custom Progress HUD | `lib/core/widgets/custom_progress_hud.dart` |
| Custom Text Field | `lib/core/widgets/custom_text_field.dart` |
| Fruit Item | `lib/core/widgets/fruit_item.dart` |
| Notification Widget | `lib/core/widgets/notification_widget.dart` |
| Password Field | `lib/core/widgets/password_field.dart` |
| Search Text Field | `lib/core/widgets/search_text_field.dart` |

---

## 12. Helper Functions

| Helper | File |
|--------|------|
| Build Error Snackbar | `lib/core/helper_functions/build_error_bar.dart` |
| Get Average Rating | `lib/core/helper_functions/get_avg_rating.dart` |
| Get Currency | `lib/core/helper_functions/get_currency.dart` |
| Get Dummy Product | `lib/core/helper_functions/get_dummy_product.dart` |
| Get User | `lib/core/helper_functions/get_user.dart` |
| Route Generator | `lib/core/helper_functions/on_generate_routes.dart` |

---

## 13. Error Handling

| Component | File |
|-----------|------|
| Exceptions | `lib/core/errors/exceptions.dart` |
| Failures | `lib/core/errors/failures.dart` |

Uses `dartz` `Either<Failure, T>` pattern for functional error handling across all repository methods.

---

## 14. Localization

| File | Description |
|------|-------------|
| `lib/l10n/app_ar.arb` | Arabic translations |
| `lib/l10n/app_en.arb` | English translations |
| `lib/l10n/app_localizations.dart` | Localizations delegate |
| `lib/l10n/app_localizations_ar.dart` | Arabic generated |
| `lib/l10n/app_localizations_en.dart` | English generated |
| `lib/generated/l10n.dart` | Generated localization class `S` |
| `lib/generated/intl/messages_ar.dart` | intl Arabic messages |
| `lib/generated/intl/messages_en.dart` | intl English messages |
| `l10n.yaml` | Localization configuration |

**Supported Locales**: Arabic (ar) — default, English (en)

---

## 15. Navigation / Routing

| File | Description |
|------|-------------|
| `lib/core/helper_functions/on_generate_routes.dart` | Named route generator |

**Available Routes**:
| Route Name | View | Description |
|------------|------|-------------|
| `splashView` | `SplashView` | App splash screen |
| `onBoardingView` | `OnBoardingView` | First-time intro |
| `signinView` | `SigninView` | Login screen |
| `signupView` | `SignupView` | Registration screen |
| `home_view` | `MainView` | Main app (home + cart + products) |
| `bestSellingView` | `BestSellingView` | Best sellers list |
| `checkoutView` | `CheckoutView` | Checkout (requires CartEntity arg) |

---

## 16. Assets

### Fonts
- Cairo Regular, Medium, SemiBold, Bold (`assets/fonts/`)

### Images (`assets/images/`)
- App icon and logo
- Onboarding illustrations (SVG)
- Social login icons (Google, Facebook, Apple)
- UI icons (filter, notification, search, trash, edit, check)
- Featured item background
- Vuesax icon set (`assets/images/vuesax/bold/`, `assets/images/vuesax/outline/`)

---

## 17. App Configuration

| File | Purpose |
|------|---------|
| `lib/constants.dart` | App-wide constants (padding, SharedPreferences keys) |
| `lib/firebase_options.dart` | Firebase platform config |
| `analysis_options.yaml` | Dart linter rules |
| `pubspec.yaml` | Dependencies and assets |
| `l10n.yaml` | Localization generation config |
| `devtools_options.yaml` | DevTools configuration |
