---
name: Mint & Emerald Finance
colors:
  surface: '#f5fbf5'
  surface-dim: '#d5dcd6'
  surface-bright: '#f5fbf5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff5ef'
  surface-container: '#e9efe9'
  surface-container-high: '#e4eae4'
  surface-container-highest: '#dee4de'
  on-surface: '#171d19'
  on-surface-variant: '#3d4a42'
  inverse-surface: '#2c322e'
  inverse-on-surface: '#ecf2ec'
  outline: '#6d7a72'
  outline-variant: '#bccac0'
  surface-tint: '#006c4a'
  primary: '#006948'
  on-primary: '#ffffff'
  primary-container: '#00855d'
  on-primary-container: '#f5fff7'
  inverse-primary: '#68dba9'
  secondary: '#bb0112'
  on-secondary: '#ffffff'
  secondary-container: '#e02928'
  on-secondary-container: '#fffbff'
  tertiary: '#9b3e3b'
  on-tertiary: '#ffffff'
  tertiary-container: '#ba5551'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#85f8c4'
  primary-fixed-dim: '#68dba9'
  on-primary-fixed: '#002114'
  on-primary-fixed-variant: '#005137'
  secondary-fixed: '#ffdad6'
  secondary-fixed-dim: '#ffb4ab'
  on-secondary-fixed: '#410002'
  on-secondary-fixed-variant: '#93000b'
  tertiary-fixed: '#ffdad7'
  tertiary-fixed-dim: '#ffb3ae'
  on-tertiary-fixed: '#410004'
  on-tertiary-fixed-variant: '#7f2928'
  background: '#f5fbf5'
  on-background: '#171d19'
  surface-variant: '#dee4de'
typography:
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  number-display:
    fontFamily: Inter
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
  number-list:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 20px
  gutter: 12px
---

## Brand & Style

The brand identity is built on the pillars of "Financial Vitality" and "Clarity." This design system employs a **Modern Corporate** aesthetic with a fresh, organic twist. It aims to reduce the anxiety associated with expense management by using a soothing, nature-inspired palette and generous whitespace.

The target audience is young professionals who value efficiency and professional-grade tools but prefer a friendly, accessible interface over traditional banking "stiffness." The emotional response should be one of control, optimism, and calm. The use of soft mint backgrounds combined with high-impact emerald greens signifies growth and positive financial health.

## Colors

The color palette is functionally driven to provide immediate cognitive feedback regarding financial status:

- **Emerald Green (Primary):** Reserved for growth, income, positive balances, and primary "Success" actions like saving a transaction.
- **Deep Red (Expense):** Used exclusively for outgoing cash flow and negative indicators to ensure high visibility.
- **Mint White (Background):** Replaces harsh standard whites to provide a distinctive, "fresh" canvas that reduces eye strain.
- **Pure White (Surfaces):** Used for interactive cards and list items to create a clear separation from the background.
- **Charcoal & Slate (Typography):** Provides a high-contrast hierarchy for readability without the starkness of pure black.

## Typography

This design system prioritizes legibility and data alignment. **Hanken Grotesk** is used for headlines to provide a modern, sharp character. **Inter** is utilized for all functional and body text due to its exceptional readability at small sizes.

Financial data must always use **Tabular Figures** (`tnum`) to ensure that decimals and commas align vertically in lists, allowing users to scan amounts quickly. A clear hierarchy is established by using Semi-bold weights for primary headers and Slate Gray for secondary descriptors.

## Layout & Spacing

The design system utilizes a **Fluid Grid** model optimized for mobile viewport constraints. The layout relies on a 4px baseline rhythm to maintain vertical consistency.

Standard page margins are set at 20px to ensure content doesn't feel cramped against the device edges. Transaction lists and dashboard cards use a 12px gutter. Components are grouped using logical proximity—related items (like a transaction title and its category) are separated by 4px, while distinct card elements are separated by 16px.

## Elevation & Depth

Hierarchy is established through **Ambient Shadows** and **Tonal Layering**.

1.  **Level 0 (Background):** The Soft Mint White surface acts as the furthest back layer.
2.  **Level 1 (Cards):** Pure White surfaces with a very soft, diffused shadow (8px blur, 4% opacity, tinted with #059669) are used for transactions and dashboard widgets.
3.  **Level 2 (Active States/Modals):** Elements like "Add Transaction" buttons or focused input fields use a more pronounced shadow (16px blur, 10% opacity) to signify interaction.
4.  **Tonal Accents:** Large summary headers (e.g., "Monthly Outlook") use solid Emerald Green fills to ground the page and pull the most important information forward.

## Shapes

The shape language is friendly yet structured, utilizing significant rounding to evoke a modern, app-centric feel.

Standard cards and primary action buttons utilize a **24px (3.0rem)** radius to create a distinctively soft, organic container. Secondary elements like input fields and small icons background circles use a **16px (2.0rem)** radius. Navigation elements and chips utilize a fully rounded (pill) style to distinguish them as interactive tokens.

## Components

### Buttons
- **Primary:** Solid Emerald Green with white text. 24px corner radius. High-contrast and heavy weight.
- **Secondary/Toggle:** Use a light grey or mint background with dark charcoal text for inactive states; transition to solid green for active "Income" or deep red for "Expense."

### Cards & Lists
- **Transaction Items:** Pure white background, 16px padding, 24px corner radius. Features a flat icon on the left inside a 40px subtle mint circle. Amount is right-aligned using tabular figures.
- **Dashboard Widgets:** Large Emerald Green cards for primary balance display. Use white text for high contrast on these surfaces.

### Inputs
- Clean, outlined fields with a 12px radius. When focused, the border transitions to Emerald Green. Placeholder text uses Slate Gray.

### Navigation
- **Bottom Bar:** Pure white background with a subtle top border. Icons use Emerald Green for the active state and Slate Gray for inactive, accompanied by 10px labels.
- **Floating Action Button (FAB):** A circular Emerald Green button with a white "+" icon, placed with a high elevation shadow to indicate primary importance.