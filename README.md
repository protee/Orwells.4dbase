<div align="center">

<!-- Header with left text and right logo -->
<div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
  <div style="text-align: left;">
    <strong style="font-size: 1.2em;">The Real and The Fake.</strong><br>
    <strong style="font-size: 1em;">Mantra:</strong> Question the construct, clarify the meaning.<br>
    <strong style="font-size: 1em;">Tagline:</strong> Learn, then build.
  </div>
  <div>
    <img src="https://www.protee.org/images/Orwells/Orwells.png" alt="Orwells Logo" width="120" style="border-radius: 12px;">
  </div>
</div>

<!-- Title and badges -->
# Orwells – The Real and The Fake

[![4D HDI](https://img.shields.io/badge/4D-HDI-blue)](#)
[![4D SRC](https://img.shields.io/badge/4D-SRC-blue)](#)
[![License: Free](https://img.shields.io/badge/License-Free-brightgreen.svg)](#license)
[![Platform: macOS & Windows](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows-lightgrey)](#)
[![4D v21](https://img.shields.io/badge/4D-v21%2B-brightgreen)](#)

</div>

---

## Overview

**Orwells** is the foundational **How-Do-I (HDI)** for `zen_Nucleus` – the perfect starting point for understanding the core concepts and capabilities of the ogTools suite's powerful ORDA framework. It is a clear, focused demonstration that teaches through a manageable, real-world example.

More than a simple demo, Orwells is a testament to what you can build. It models a complex content management system for analyzing textual content (Sessions, Speeches, and Fragments) through a lens of philosophical and linguistic dualities, showcasing the power and precision of `zen_Nucleus` and the ogTools suite.

---

## Why Orwells?

**Orwells is your guide to mastering the ogTools ecosystem.** It's designed to be explored, understood, and adapted.

- **See Best Practices in Action:** Explore a real-world implementation of `zen_Nucleus` and the ogTools suite, demonstrating relationship management, UI binding, and widget customization.
- **Learn by Example:** Understand complex concepts by studying a fully functional application that manages intricate data relationships with an elegant UI.
- **Full Source Code Included:** The complete source code for the main database is provided. Dive in, see how it works, and adapt any part of it for your own projects.

**Don't just see what's possible—learn how to achieve it yourself.**

---

## Key Features

### A Complex Content Management Model

The application manages **Sessions**, which are composed of **Speeches**, themselves made up of individual **Fragments**. The real power lies in how these fragments are cataloged and analyzed. Each fragment is linked to a rich set of contextual data from the **Orwells** and **Categories** tables, which contains assertions defined by nuanced dualities:

- **Yin & Yang**: A philosophical true/fake dichotomy.
- **Plain Speech vs. Obfuscation**: Distinguishing genuine language from bureaucratic or misleading "doublespeak."
- **Source/Target Translation**: Managing meaning across languages.
- **Keyword Tagging**: Simple or dual-keyword systems for deep categorization.

This complex relational structure is the perfect showcase for `zen_Nucleus`, effortlessly handling the intricate web of relationships (`Sessions ← Speeches ← Fragments → Orwells → Categories`) and providing the powerful UI to manage it all.

### Feature Highlight: The Speech Player

Orwells includes a beautiful, dynamic SVG interface to bring data to life. The Speech Player allows you to:

- Play through Speeches in an engaging, visual format.
- Filter content on the fly using options like Randomize, Yin (True), Yang (Fake), or Both.
- Get inspired by the flow of ideas and the juxtaposition of concepts.

A complementary viewer with a listbox is also provided for a traditional, detailed analysis of the content. This interactive experience doesn't just show your data—it lets you feel the powerful structures built by `zen_Nucleus` and beautifully rendered by the ogTools Suite.

### Beautiful, Responsive UI

Orwells demonstrates the power of the ogTools suite widgets, delivering a beautiful, responsive, and intuitive interface. Key elements include:

- Dynamic SVG interfaces (like the Speech Player).
- `zen_c4ES` and `waz_switch` widgets in host forms shared with `zen_Nucleus`.
- Seamless integration of all suite components for a cohesive user experience.

---

## Architecture & Data Model

Orwells models a content management system for analyzing textual content through a lens of philosophical and linguistic dualities.

### Core Entities

- **[SESSIONS]**: The top-level container for a set of related content.
- **[SPEECHES]**: Belongs to a Session. A specific discourse or presentation.
- **[FRAGMENTS]**: The atomic unit of content. Each Fragment belongs to a Speech.
- **[ORWELLS]**: Represents a "concept" or "assertion" that can be applied to a Fragment. This is the heart of the analytical model.
- **[CATEGORIES]**: Provides a classification system for Orwells (e.g., Yin/Yang, Plain/Obfuscated).

### Key Relationships

The power of the model lies in its interconnectedness, all managed seamlessly by `zen_Nucleus`:
- A **Session** has many **Speeches**.
- A **Speech** has many **Fragments**.
- A **Fragment** is linked to multiple **Orwells** (and vice-versa).
- An **Orwells** entry is classified by a **Category**.

This structure allows for deep, multi-dimensional analysis of textual content.

---

## Installation & Dependencies

### Prerequisites
- **4D v21** or higher (for `4DPop` dependency).
- An **ogTools Suite lifetime license** is embedded into Sēmippān.
- The following ogTools components are required (and included in the suite):
  - `wok_Krolific` – Licensing, Simplified
  - `wox_Xlibrary` – The Silent Engine
  - `woc_Colours` – Colours, Reloaded
  - `waz_Wazar` – UI, Unified
  - `wob_Boxes` – The Universal Container
  - `wor_Recursive` – The Infinite, Tamed
  - `wos_SvgWidgets` – Draw your verses
  - `wqr_QuickReport` – A 4D legacy fork
  - `zen_Nucleus` – The Final Verse

### Installation (GitHub)

Clone/download the project from the following Git URL: `protee/orwells.4dbase`. To try it with sample data, download SampleData.zip from the Releases page and unzip its contents into Data/.

> **Note**: For team development, commit the dependency configuration file (`dependencies.json`) to your source control.

---

## Part of the ogTools Suite

Sēmippān is a flagship HDI within the comprehensive **ogToolsSuite**—an integrated development ecosystem for 4D. Other key components include:

| Icon | Component | Description |
|------|-----------|-------------|
| <img src="https://www.protee.org/images/wok_Krolific/wok_Krolific.png" alt="wok_Krolific Logo" width="60" style="border-radius: 12px;"> | **wok_Krolific** | License manager. |
| <img src="https://www.protee.org/images/wox_Xlibrary/wox_Xlibrary.png" alt="wox_Xlibrary Logo" width="60" style="border-radius: 12px;"> | **wox_Xlibrary** | Core utilities for everyday development tasks. |
| <img src="https://www.protee.org/images/wod_DevTools/wod_DevTools.png" alt="wod_DevTools Logo" width="60" style="border-radius: 12px;"> | **wod_DevTools** | Developer tools, instant documentation generation. |
| <img src="https://www.protee.org/images/wom_Make/wom_Make.png" alt="wom_Make Logo" width="60" style="border-radius: 12px;"> | **wom_Make** | Sophisticated builder. |
| <img src="https://www.protee.org/images/woc_Colours/woc_Colours.png" alt="woc_Colours Logo" width="60" style="border-radius: 12px;"> | **woc_Colours** | Advanced, indexed color management engine. |
| <img src="https://www.protee.org/images/waz_Wazar/waz_Wazar.png" alt="waz_Wazar Logo" width="60" style="border-radius: 12px;"> | **waz_Wazar** | Intelligent UI widgets for modern interfaces. |
| <img src="https://www.protee.org/images/wob_Boxes/wob_Boxes.png" alt="wob_Boxes Logo" width="60" style="border-radius: 12px;"> | **wob_Boxes** | Secure, Dropbox-like file repository. |
| <img src="https://www.protee.org/images/wor_Recursive/wor_Recursive.png" alt="wor_Recursive Logo" width="60" style="border-radius: 12px;"> | **wor_Recursive** | Manage hierarchical data with ease. |
| <img src="https://www.protee.org/images/wqr_QuickReport/wqr_QuickReport.png" alt="wqr_QuickReport Logo" width="60" style="border-radius: 12px;"> | **wqr_QuickReport** | A fork of 4D QuickReport with ORDA wrapper. |
| <img src="https://www.protee.org/images/zen_Nucleus/zen_Nucleus.png" alt="zen_Nucleus Logo" width="60" style="border-radius: 12px;"> | **zen_Nucleus** | The complete full ORDA framework, where every component finds its meaning. |

> Together, these components form a powerful framework that allows developers to focus on unique business logic rather than reinventing the wheel.

---

## License

Orwells is a **free HDI** and is part of the ogTools suite. No valid license is required for use. An **ogTools Suite lifetime license for Orwells** is included within the product. 

---

## Localization

- Orwells supports the following languages out‑of‑the‑box: 🇺🇸 English (EN)
- ogToolsSuite supports the following languages out‑of‑the‑box: 🇺🇸 English (EN), 🇫🇷 French (FR), 🇪🇸 Spanish (ES), 🇩🇪 German (DE)

---

## Support & Resources

- **Official Website**: [https://www.protee.org](https://www.protee.org)
- **Product Page**: [https://www.protee.org/index.php/products-hdi/orwells](https://www.protee.org/index.php/products-hdi/orwells)
- **Documentation**: Full documentation and HDI demos are included with your purchase.

For direct inquiries:
- **Email**: [info@protee.org](mailto:info@protee.org)

---

## About the Creator

Orwells and the ogToolsSuite are developed by **Protée sarl**, a company with over 30 years of expertise in 4D development. Led by Olivier Grimbert, the team focuses on delivering high‑quality, production‑grade tools that enhance developer productivity and application reliability.

---

<div align="center">
  <sub>Built with ❤️ for the 4D community by Protée sarl. © 2016 - Present</sub>
</div>