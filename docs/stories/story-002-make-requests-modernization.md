# Story 002: MakeRequests.jsx Modernization

**Status**: Draft  
**Priority**: High (P1)  
**Estimated Effort**: 2-3 hours  
**Component**: `/frontend/src/pages/MakeRequests.jsx`  

## Story Description

Convert the MakeRequests.jsx page from SCSS modules to Tailwind CSS v4, implementing the established modernization pattern. This is a critical user-facing component that allows physicians to submit time-off and volunteer requests.

## Context

The MakeRequests page is currently using `MakeRequests.module.scss` and contains calendar interface functionality for physicians to select dates and submit requests. This page is heavily used by end-users and must maintain excellent mobile experience while applying the emerald theme consistency.

## Acceptance Criteria

### Core Modernization
- [ ] Remove SCSS module import: `import MakeRequestsStyle from '../assets/styles/MakeRequests.module.scss'`
- [ ] Convert all `className={MakeRequestsStyle.class}` references to Tailwind CSS v4 classes
- [ ] Apply emerald theme (#10b981) for primary actions, selected dates, and active states
- [ ] Maintain all existing functionality (calendar navigation, date selection, request submission)

### Calendar Interface Modernization
- [ ] Modernize calendar grid layout with Tailwind CSS
- [ ] Implement proper hover states and selected date highlighting
- [ ] Ensure calendar is touch-friendly on mobile devices
- [ ] Maintain month navigation functionality with modern styling

### Code Quality & Safety
- [ ] Implement safe data access patterns: `safeGet()`, `safeArray()`, `safeString()`
- [ ] Add loading states with `<LoadingSpinner />` for request submissions
- [ ] Wrap component content with `<ErrorBoundary>` for error handling
- [ ] Ensure all date operations and API calls are safely handled

### Mobile-First Design
- [ ] Prioritize mobile experience (physicians use phones frequently)
- [ ] Implement responsive calendar that works well on small screens
- [ ] Ensure form inputs are properly sized for mobile touch
- [ ] Test date selection usability on touch devices

### Integration
- [ ] Verify integration with `ModernSidebar` navigation
- [ ] Ensure proper routing from other pages (auto-approve flow)
- [ ] Test with various user role permissions
- [ ] Verify request submission integrates with backend API

### Cleanup
- [ ] Remove `MakeRequests.module.scss` file after successful conversion
- [ ] Update any test files to reflect new class names
- [ ] Verify no other components import the deleted SCSS file

## Technical Implementation Notes

### Current State Analysis
```jsx
// Current imports
import MakeRequestsStyle from '../assets/styles/MakeRequests.module.scss';

// Typical usage patterns to convert
className={MakeRequestsStyle.container}
className={MakeRequestsStyle.calendarGrid}
className={MakeRequestsStyle.dateCell}
className={MakeRequestsStyle.selectedDate}
className={MakeRequestsStyle.submitButton}
```

### Expected Modernization Pattern
```jsx
// New imports (add these)
import LoadingSpinner from '../components/LoadingSpinner';
import EmptyState from '../components/EmptyState';
import ErrorBoundary from '../components/ErrorBoundary';

// Safe data access helpers
const safeGet = (obj, path, defaultValue = null) => {
  try {
    return path.split('.').reduce((current, key) => current?.[key], obj) ?? defaultValue;
  } catch { return defaultValue; }
};

// Example conversions
className="max-w-4xl mx-auto p-4 sm:p-6"                           // container
className="grid grid-cols-7 gap-1 bg-white rounded-lg p-4"        // calendarGrid
className="aspect-square flex items-center justify-center rounded-md hover:bg-gray-100 cursor-pointer"  // dateCell
className="bg-emerald-500 text-white font-semibold hover:bg-emerald-600"  // selectedDate
className="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-3 px-6 rounded-lg font-semibold"  // submitButton
```

### Key UI Components to Modernize
1. **Calendar Grid**: Responsive 7-column grid with proper spacing
2. **Date Cells**: Interactive date cells with hover and selection states
3. **Month Navigation**: Previous/next month controls with modern styling
4. **Request Form**: Form inputs for request details and comments
5. **Submit Actions**: Primary submit button with loading states
6. **Request Type Selection**: Dropdown or radio buttons for request types
7. **Loading States**: During form submission and data loading

### Mobile Responsive Considerations
- Larger touch targets for date cells (min 44px)
- Proper spacing between calendar elements
- Stack form elements vertically on mobile
- Ensure month navigation buttons are easily tappable
- Consider swipe gestures for month navigation

### Calendar Accessibility
- Proper keyboard navigation between dates
- Screen reader support for date selection
- ARIA labels for calendar navigation
- Focus management when selecting dates

## Testing Requirements

### Manual Testing Checklist
- [ ] Page loads without SCSS dependency errors
- [ ] Calendar navigation works (previous/next month)
- [ ] Date selection highlights properly with emerald theme
- [ ] Request submission works with loading states
- [ ] Mobile touch interaction is smooth and responsive
- [ ] Integration with navigation sidebar functions properly
- [ ] Form validation works correctly

### Automated Testing
- [ ] Update existing test files for new class names
- [ ] Add tests for responsive calendar behavior
- [ ] Test error boundary functionality with network failures
- [ ] Verify date selection state management
- [ ] Test form validation logic

### Mobile Testing Priority
- [ ] iPhone Safari testing (common physician device)
- [ ] Android Chrome testing
- [ ] Touch interaction accuracy on small screens
- [ ] Orientation change handling (portrait/landscape)

## Definition of Done

### Functional Requirements
- [ ] All existing MakeRequests functionality preserved
- [ ] Page renders without any SCSS module dependencies
- [ ] Emerald theme applied consistently throughout calendar
- [ ] Mobile-first responsive design implemented and tested
- [ ] Loading, success, and error states properly implemented

### Quality Requirements  
- [ ] No console errors or warnings
- [ ] Component integrates properly with ModernSidebar
- [ ] Tests pass with maintained/improved coverage
- [ ] Mobile usability is excellent (primary user experience)
- [ ] Performance is maintained or improved

### Cleanup Requirements
- [ ] `MakeRequests.module.scss` file deleted from project
- [ ] No other files reference the deleted SCSS module
- [ ] Git commit includes both component changes and SCSS file deletion

## Dev Agent Record

**Status**: Ready for Development  
**Agent Model Used**: _[To be filled by dev agent]_  
**Debug Log References**: _[To be added during development]_  

### Tasks
- [ ] Task 1: Remove SCSS imports and analyze calendar structure
- [ ] Task 2: Convert container and main layout to Tailwind
- [ ] Task 3: Modernize calendar grid with responsive design
- [ ] Task 4: Implement emerald theme for date selection states
- [ ] Task 5: Convert month navigation controls
- [ ] Task 6: Modernize request form interface
- [ ] Task 7: Add loading states and error boundaries
- [ ] Task 8: Optimize for mobile touch interaction
- [ ] Task 9: Test integration, cleanup SCSS, and verify functionality

### Completion Notes
_[To be filled during development]_

### File List
_[To be updated with files created/modified during development]_

### Change Log
_[To be updated during development]_

---

**Ready for Implementation**: This story prioritizes mobile experience and contains all necessary context for the dev agent to proceed with modernization.