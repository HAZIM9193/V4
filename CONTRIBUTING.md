# Contributing to Roblox Code Executor

Thank you for your interest in contributing to the Roblox Code Executor project! 🎉

## 🤝 How to Contribute

### Reporting Bugs 🐛

If you find a bug, please create an issue with:
- **Clear title** describing the problem
- **Steps to reproduce** the bug
- **Expected behavior** vs actual behavior
- **Screenshots** if applicable
- **Environment details** (Roblox Studio version, OS, etc.)

### Suggesting Features 💡

We welcome feature suggestions! Please:
- Check existing issues to avoid duplicates
- Provide a clear description of the feature
- Explain why it would be useful
- Include mockups or examples if possible

### Code Contributions 💻

#### Before You Start
1. Fork the repository
2. Create a new branch for your feature/fix
3. Check the existing code style
4. Test your changes thoroughly

#### Development Setup
1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/roblox-code-executor.git
   ```
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes
4. Test in Roblox Studio

#### Code Style Guidelines

**Lua Conventions:**
- Use `camelCase` for variable names
- Use `PascalCase` for functions and classes
- Add comments for complex logic
- Keep lines under 120 characters
- Use meaningful variable names

**Example:**
```lua
-- Good
local function animateRainbow()
    if rainbowAnimationRunning then return end
    rainbowAnimationRunning = true
    -- ... rest of function
end

-- Avoid
local function a()
    if r then return end
    r = true
end
```

**UI Guidelines:**
- Follow the existing color scheme
- Maintain consistent spacing and sizing
- Use TweenService for animations
- Add hover effects for interactive elements

#### Submitting Changes

1. **Commit your changes:**
   ```bash
   git add .
   git commit -m "Add feature: description of what you added"
   ```

2. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request:**
   - Use a clear title and description
   - Reference any related issues
   - Add screenshots for UI changes
   - Test that your changes work

#### Pull Request Guidelines

**Title Format:**
- `Add:` for new features
- `Fix:` for bug fixes
- `Update:` for improvements
- `Remove:` for deletions

**Examples:**
- `Add: Sound effects for button interactions`
- `Fix: Clear button not working on mobile`
- `Update: Improve rainbow animation performance`

**Description Should Include:**
- What changes were made
- Why the changes were needed
- How to test the changes
- Screenshots (for UI changes)

## 🎨 Areas We Need Help With

### High Priority
- 🎵 **Sound Effects**: Add audio feedback for interactions
- 📱 **Mobile Optimization**: Improve touch controls
- 🎨 **Theme System**: Multiple color themes
- 📁 **Script Saving**: Local storage functionality

### Medium Priority
- 🔍 **Syntax Highlighting**: Code editor improvements
- 📊 **Performance Monitoring**: FPS and memory display
- 🌐 **Localization**: Multi-language support
- 🔌 **Plugin System**: Extensibility framework

### Documentation
- 📖 **Tutorials**: Step-by-step guides
- 🎥 **Video Guides**: Screen recordings
- 📝 **Code Examples**: More script samples
- 🔧 **API Documentation**: Function references

## 🧪 Testing

Before submitting, please test:
- **Basic functionality**: All buttons work
- **Code execution**: Both regular and loadstring
- **Animations**: Rainbow and sparkles working
- **Keyboard shortcuts**: Ctrl+Enter and Ctrl+Delete
- **Error handling**: Invalid code doesn't break GUI
- **Mobile compatibility**: Works on touch devices

### Test Checklist
- [ ] GUI opens and closes properly
- [ ] Code execution works
- [ ] Loadstring URLs work
- [ ] Clear button functions
- [ ] Animations are smooth
- [ ] No console errors
- [ ] Mobile-friendly (if applicable)

## 🏷️ Issue Labels

We use these labels to organize issues:

- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Improvements to docs
- `good first issue` - Easy for newcomers
- `help wanted` - Extra attention needed
- `question` - Further information requested
- `duplicate` - Already exists
- `wontfix` - Not planned to be fixed

## 📋 Code Review Process

1. **Automatic checks** run on PRs
2. **Maintainer review** for code quality
3. **Testing** on different environments
4. **Merge** after approval

## 🎯 Coding Standards

### Performance
- Minimize memory usage
- Use efficient algorithms
- Avoid infinite loops
- Clean up resources properly

### Security
- Validate user input
- Use safe execution environments
- Avoid exposing sensitive APIs
- Handle errors gracefully

### User Experience
- Provide clear feedback
- Use intuitive controls
- Maintain consistent design
- Support accessibility

## 📞 Getting Help

**Need help contributing?**
- 💬 [Open a discussion](../../discussions)
- 📧 Create an issue with `question` label
- 📖 Check existing documentation

**Want to discuss ideas?**
- 💡 [Start a discussion](../../discussions)
- 🗣️ Join community conversations

## 🏆 Recognition

Contributors will be:
- Added to the contributors list
- Mentioned in release notes
- Given credit in the README

## 📜 Code of Conduct

Please be:
- **Respectful** to all contributors
- **Constructive** in feedback
- **Patient** with newcomers
- **Professional** in communications

Thank you for contributing to make this project better! 🚀

---

**Questions?** Feel free to open an issue or start a discussion!