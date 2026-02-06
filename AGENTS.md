# SwiftUI-TCA-Template Agent Guide

## Scope
- This file applies to this repository and overrides global defaults when they conflict.

## Workspace Behavior (Important)
- `Xcode/Name.xcworkspace` intentionally references the repo root (`group:../`) so Swift Package schemes are loaded.
- Because of that, Xcode Navigator shows `Name.xcodeproj` twice:
- One is a folder-like item under the repo tree.
- One is the real Xcode project container.
- This is expected behavior, not project corruption.
- `Xcode/<App>.xcodeproj/project.xcworkspace/contents.xcworkspacedata` must exist and contain a `self:` `FileRef`.
- If this file is missing, Xcode GUI may treat `.xcodeproj` like a plain folder/file instead of a project.

## Swift Macros Requirement
- This project uses Swift Macros (for example via TCA-related dependencies).
- Without enabling macro fingerprint skip in Xcode, builds may fail during macro validation.
- Run this once on the machine before building in Xcode:
```bash
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
```

## Template Rename Workflow
- Goal: replace the template placeholder `Name` with a concrete app name (for example `AcmeApp`) safely and consistently.
- Do all steps before regular feature work.

1. Set the new name.
```bash
NEW_NAME="AcmeApp"
```

2. Rename template paths.
```bash
mv "Xcode/Name.xcworkspace" "Xcode/${NEW_NAME}.xcworkspace"
mv "Xcode/Name.xcodeproj" "Xcode/${NEW_NAME}.xcodeproj"
mv "Xcode/Name" "Xcode/${NEW_NAME}"
mv "Xcode/${NEW_NAME}/Name.entitlements" "Xcode/${NEW_NAME}/${NEW_NAME}.entitlements"
mv "Xcode/${NEW_NAME}/Name.xctestplan" "Xcode/${NEW_NAME}/${NEW_NAME}.xctestplan"
mv "Xcode/${NEW_NAME}.xcodeproj/xcshareddata/xcschemes/Name.xcscheme" "Xcode/${NEW_NAME}.xcodeproj/xcshareddata/xcschemes/${NEW_NAME}.xcscheme"
```

3. Replace `Name` token usage in project metadata.
```bash
perl -pi -e "s/\\bName\\b/${NEW_NAME}/g" \
  "Xcode/${NEW_NAME}.xcworkspace/contents.xcworkspacedata" \
  "Xcode/${NEW_NAME}.xcodeproj/project.pbxproj" \
  "Xcode/${NEW_NAME}.xcodeproj/xcshareddata/xcschemes/${NEW_NAME}.xcscheme"
```

4. Set package app name to match the project name.
```bash
perl -pi -e "s/^let appName = \".*\"/let appName = \"${NEW_NAME}\"/" Package.swift
```

5. Verify no stale placeholder remains in tracked project files.
```bash
rg -n "\\bName\\b" Xcode Package.swift
```

6. Verify Xcode can read workspace/project after rename.
```bash
xcodebuild -list -workspace "Xcode/${NEW_NAME}.xcworkspace"
xcodebuild -list -project "Xcode/${NEW_NAME}.xcodeproj"
```

## Notes
- If `PRODUCT_BUNDLE_IDENTIFIER` should also change, edit `Xcode/${NEW_NAME}.xcodeproj/project.pbxproj` accordingly (default template uses `com.yourcompany.<AppName>`).
- Do not modify `Xcode/<App>.xcworkspace` to remove the repo-root `FileRef`; doing so hides Swift Package schemes from the workspace.
- This project uses TCA. If you have a Point-Free subscription and are signed in to use the `pfw` skill, you may use it for development in this project.
